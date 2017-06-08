defmodule Fit.DefinitionRecord do
  def parse(<< def_record::binary-size(5), rest::binary >>) do
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
    {Map.put(meta, :fields, fields), rest}
  end

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

  def parse_field_def(rest, 0, fields) do
    {fields, rest}
  end
end
