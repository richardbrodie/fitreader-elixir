defmodule Fit.DefinitionRecord do
  defstruct [:endian, :global_msg, :num_fields, :field_defs]
  def parse(<< def_record::binary-size(5), rest::binary >>, has_developer_fields, dev_pid) do
    meta = case def_record do
      << _reserved     ::little-8,
         0             ::little-8,
         global_msg    ::little-16,
         num_fields    ::little-8
      >> ->
        %{endian: :little, global_msg: global_msg, num_fields: num_fields}
      << _reserved     ::little-8,
         1             ::little-8,
         global_msg    ::big-16,
         num_fields    ::little-8
      >> ->
        %{endian: :big, global_msg: global_msg, num_fields: num_fields}
    end
    {fields, rest} = parse_field_def(rest, meta.num_fields, [])
    definition = Map.put(meta, :field_defs, fields)
    if has_developer_fields == 1 do
      <<num_fields::little-8, rest::binary>> = rest
      {dev_fields, rest} = parse_dev_field_defs(rest, dev_pid, num_fields, [])
      definition = Map.put(definition, :dev_field_defs, dev_fields)
    end
    {definition, rest}
  end

  def parse_field_def(rest, 0, fields), do: {Enum.reverse(fields), rest}
  def parse_field_def(data, num_fields, fields) when num_fields > 0 do
    <<
      field_def_num,
      size,
      endianness::1,
      _::2,
      base_num::5,
      rest::binary
    >> = data
    f = %{
          field_def_num: field_def_num,
          size: size,
          endianness: endianness,
          base_num: base_num
        }
    parse_field_def(rest, num_fields-1, [f | fields])
  end

  def parse_dev_field_defs(rest, _dev_pid, 0, dev_fields), do: {Enum.reverse(dev_fields), rest}
  def parse_dev_field_defs(data, dev_pid, num_fields, dev_fields) do
    <<
      field_num,
      size,
      developer_data_index,
      rest::binary
    >> = data
    field_def = Agent.get(dev_pid, &Map.get(&1, developer_data_index))
    f = %{
          field_num: field_num,
          size: size,
          developer_data_index: developer_data_index,
          field_def: field_def
        }
    parse_dev_field_defs(rest, dev_pid, num_fields-1, [f | dev_fields])
  end
end
