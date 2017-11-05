defmodule Fit.DataRecordLittle do
  def parse_fields([], fields, data), do: {fields, data}
  def parse_fields(field_defs, fields, data) do
    [%{base_num: base_num, field_def_num: field_def_num, size: size} | tail] = field_defs
    {result, rest} = parse_data(base_num, size, data, [])
    new_fields = case result do
      nil -> fields
      [] -> fields
      [value|[]] -> [{field_def_num, value} | fields]
      _ -> [{field_def_num, result} | fields]
    end
    parse_fields(tail, new_fields, rest)
  end

  def parse_dev_fields([], fields, data), do: {fields, data}
  def parse_dev_fields([%{size: size, field_def: field_def} | new_field_defs], fields, data) do
    %{base_type_id: base_type_id, field_name: field_name} = field_def
    {result, rest} = parse_data(base_type_id, size, data, [])
    new_fields = case result do
      nil -> fields
      _ -> [{field_name, result} | fields]
    end
    parse_dev_fields(new_field_defs, new_fields, rest)
  end

  def parse_data(0, 0, data, value), do: {value, data}
  def parse_data(0, size, data, values) do
    <<field, rest::binary>> = data
    valid_vals = case field do
                   255 -> values
                   _ -> [field|values]
                 end
    parse_data(0, size-1, rest, valid_vals)
  end

  def parse_data(1, 0, data, value), do: {value, data}
  def parse_data(1, size, data, values) do
    <<field::signed-integer, rest::binary>> = data
    valid_vals = case field do
                   127 -> values
                   _ -> [field|values]
                 end
    parse_data(1, size-1, rest, valid_vals)
  end

  def parse_data(2, 0, data, value), do: {value, data}
  def parse_data(2, size, data, values) do
    <<field, rest::binary>> = data
    valid_vals = case field do
                   255 -> values
                   _ -> [field|values]
                 end
    parse_data(2, size-1, rest, valid_vals)
  end

  def parse_data(3, 0, data, value), do: {value, data}
  def parse_data(3, size, data, values) do
    <<field::signed-little-integer-size(16), rest::binary>> = data
    valid_vals = case field do
                   32767 -> values
                   _ -> [field|values]
                 end
    parse_data(3, size-2, rest, valid_vals)
  end

  def parse_data(4, 0, data, value), do: {value, data}
  def parse_data(4, size, data, values) do
    <<field::little-integer-size(16), rest::binary>> = data
    valid_vals = case field do
                   65535 -> values
                   _ -> [field|values]
                 end
    parse_data(4, size-2, rest, valid_vals)
  end

  def parse_data(5, 0, data, value), do: {value, data}
  def parse_data(5, size, data, values) do
    <<field::signed-little-integer-size(32), rest::binary>> = data
    valid_vals = case field do
                   2147483647 -> values
                   _ -> [field|values]
                 end
    parse_data(5, size-4, rest, valid_vals)
  end

  def parse_data(6, 0, data, value), do: {value, data}
  def parse_data(6, size, data, values) do
    <<field::little-integer-size(32), rest::binary>> = data
    valid_vals = case field do
                   4294967295 -> values
                   _ -> [field|values]
                 end
    parse_data(6, size-4, rest, valid_vals)
  end

  def parse_data(7, size, data, _values) do
    <<raw::binary-size(size), rest::binary>> = data
    [field, _] = :binary.split(raw,<<0>>)
    {field, rest}
  end

  def parse_data(8, 0, data, value), do: {value, data}
  def parse_data(8, size, data, values) do
    case valid?(data, 4294967295, size) do
      {:ok, data} ->
        <<field::signed-little-float-size(32), rest::binary>> = data
        parse_data(8, size-4, rest, [field|values])
      {:error, rest} ->
        parse_data(8, size-4, rest, values)
    end
  end

  def parse_data(9, 0, data, value), do: {value, data}
  def parse_data(9, size, data, values) do
    <<field::signed-little-float-size(64), rest::binary>> = data
    valid_vals = case field do
                   18446744073709551615 -> values
                   _ -> [field|values]
                 end
    parse_data(9, size-8, rest, valid_vals)
  end

  def parse_data(10, 0, data, value), do: {value, data}
  def parse_data(10, size, data, values) do
    <<field, rest::binary>> = data
    valid_vals = case field do
                   0 -> values
                   _ -> [field|values]
                 end
    parse_data(10, size-1, rest, valid_vals)
  end

  def parse_data(11, 0, data, value), do: {value, data}
  def parse_data(11, size, data, values) do
    <<field::little-integer-size(16), rest::binary>> = data
    valid_vals = case field do
                   0 -> values
                   _ -> [field|values]
                 end
    parse_data(11, size-2, rest, valid_vals)
  end

  def parse_data(12, 0, data, value), do: {value, data}
  def parse_data(12, size, data, values) do
    <<field::little-integer-size(32), rest::binary>> = data
    valid_vals = case field do
                   0 -> values
                   _ -> [field|values]
                 end
    parse_data(12, size-4, rest, valid_vals)
  end

  def parse_data(13, 0, data, value), do: {value, data}
  def parse_data(13, size, data, values) do
    <<field, rest::binary>> = data
    valid_vals = case field do
                   0xFF -> values
                   _ -> [field|values]
                 end
    parse_data(13, size-1, rest, valid_vals)
  end

  def parse_data(14, 0, data, value), do: {value, data}
  def parse_data(14, size, data, values) do
    <<field::little-signed-integer-size(64), rest::binary>> = data
    valid_vals = case field do
                   0x7FFFFFFFFFFFFFFF -> values
                   _ -> [field|values]
                 end
    parse_data(14, size-8, rest, valid_vals)
  end

  def parse_data(15, 0, data, value), do: {value, data}
  def parse_data(15, size, data, values) do
    <<field::little-integer-size(64), rest::binary>> = data
    valid_vals = case field do
                   0xFFFFFFFFFFFFFFFF -> values
                   _ -> [field|values]
                 end
    parse_data(15, size-8, rest, valid_vals)
  end

  def parse_data(16, 0, data, value), do: {value, data}
  def parse_data(16, size, data, values) do
    <<field::little-integer-size(64), rest::binary>> = data
    valid_vals = case field do
                   0x0 -> values
                   _ -> [field|values]
                 end
    parse_data(16, size-8, rest, valid_vals)
  end

  defp valid?(data, invalid, size) do
    case data do
      <<^invalid::unit(8)-size(size), rest::binary>> -> {:error, rest}
      _ -> {:ok, data}
    end
  end
end
