defmodule Fit.DataRecordBig do
  def parse_fields([], fields, data), do: {fields, data}
  def parse_fields(field_defs, fields, data) do
    [%{base_num: base_num, field_def_num: field_def_num, size: size} | tail] = field_defs
    {result, rest} = parse_data(base_num, size, data, [])
    new_fields = case result do
      nil -> fields
      _ -> [{field_def_num, result} | fields]
    end
    parse_fields(tail, new_fields, rest)
  end

  def parse_dev_fields([], fields, data), do: {fields, data}
  def parse_dev_fields([%{size: size, field_def: field_def} | tail], fields, data) do
    %{base_type_id: base_type_id, field_name: field_name} = field_def
    {result, rest} = parse_data(base_type_id, size, data, [])
    new_fields = case result do
      nil -> fields
      _ -> [{field_name, result} | fields]
    end
    parse_dev_fields(tail, new_fields, rest)
  end

  def parse_data(0, 0, data, values), do: {validate_fields(values, 255, []), data}
  def parse_data(0, size, data, values) do
    <<field, rest::binary>> = data
    parse_data(0, size-1, rest, [field|values])
  end

  def parse_data(1, 0, data, values), do: {validate_fields(values, 127, []), data}
  def parse_data(1, size, data, values) do
    <<field::signed-integer, rest::binary>> = data
    parse_data(1, size-1, rest, [field|values])
  end

  def parse_data(2, 0, data, values), do: {validate_fields(values, 255, []), data}
  def parse_data(2, size, data, values) do
    <<field, rest::binary>> = data
    parse_data(2, size-1, rest, [field|values])
  end

  def parse_data(3, 0, data, values), do: {validate_fields(values, 32767, []), data}
  def parse_data(3, size, data, values) do
    <<field::signed-integer-size(16), rest::binary>> = data
    parse_data(3, size-2, rest, [field|values])
  end

  def parse_data(4, 0, data, values), do: {validate_fields(values, 65535, []), data}
  def parse_data(4, size, data, values) do
    <<field::integer-size(16), rest::binary>> = data
    parse_data(4, size-2, rest, [field|values])
  end

  def parse_data(5, 0, data, values), do: {validate_fields(values, 2147483647, []), data}
  def parse_data(5, size, data, values) do
    <<field::signed-integer-size(32), rest::binary>> = data
    parse_data(5, size-4, rest, [field|values])
  end

  def parse_data(6, 0, data, values), do: {validate_fields(values, 4294967295, []), data}
  def parse_data(6, size, data, values) do
    <<field::integer-size(32), rest::binary>> = data
    parse_data(6, size-4, rest, [field|values])
  end

  def parse_data(7, size, data, values) do
    <<raw::binary-size(size), rest::binary>> = data
    [field, _] = :binary.split(raw,<<0>>)
    {[field|values], rest}
  end

  def parse_data(8, 0, data, values), do: {values, data}
  def parse_data(8, size, data, values) do
    case valid?(data, 4294967295, size) do
      {:ok, data} ->
        <<field::signed-float-size(32), rest::binary>> = data
        parse_data(8, size-4, rest, [field|values])
      {:error, rest} ->
        parse_data(8, size-4, rest, values)
    end
  end

  def parse_data(9, 0, data, values), do: {validate_fields(values, 18446744073709551615, []), data}
  def parse_data(9, size, data, values) do
    <<field::signed-float-size(64), rest::binary>> = data
    parse_data(9, size-8, rest, [field|values])
  end

  def parse_data(10, 0, data, values), do: {validate_fields(values, 0, []), data}
  def parse_data(10, size, data, values) do
    <<field, rest::binary>> = data
    parse_data(10, size-1, rest, [field|values])
  end

  def parse_data(11, 0, data, values), do: {validate_fields(values, 0, []), data}
  def parse_data(11, size, data, values) do
    <<field::integer-size(16), rest::binary>> = data
    parse_data(11, size-2, rest, [field|values])
  end

  def parse_data(12, 0, data, values), do: {validate_fields(values, 0, []), data}
  def parse_data(12, size, data, values) do
    <<field::integer-size(32), rest::binary>> = data
    parse_data(12, size-4, rest, [field|values])
  end

  def parse_data(13, 0, data, values), do: {validate_fields(values, 0xFF, []), data}
  def parse_data(13, size, data, values) do
    <<field, rest::binary>> = data
    parse_data(13, size-1, rest, [field|values])
  end

  def parse_data(14, 0, data, values), do: {validate_fields(values, 0x7FFFFFFFFFFFFFFF, []), data}
  def parse_data(14, size, data, values) do
    <<field::signed-integer-size(64), rest::binary>> = data
    parse_data(14, size-8, rest, [field|values])
  end

  def parse_data(15, 0, data, values), do: {validate_fields(values, 0xFFFFFFFFFFFFFFFF, []), data}
  def parse_data(15, size, data, values) do
    <<field::integer-size(64), rest::binary>> = data
    parse_data(15, size-8, rest, [field|values])
  end

  def parse_data(16, 0, data, values), do: {validate_fields(values, 0x0, []), data}
  def parse_data(16, size, data, values) do
    <<field::integer-size(64), rest::binary>> = data
    parse_data(16, size-8, rest, [field|values])
  end

  defp valid?(data, invalid, size) do
    case data do
      <<^invalid::unit(8)-size(size), rest::binary>> -> {:error, rest}
      _ -> {:ok, data}
    end
  end

  defp validate_fields([], _invalid, [single|[]]), do: single
  defp validate_fields([], _invalid, []), do: nil
  defp validate_fields([], _invalid, [head|tail]), do: [head|tail]
  defp validate_fields([head|tail], invalid, valid_fields) do
    case head do
      ^invalid -> validate_fields(tail, invalid, valid_fields)
      _ -> validate_fields(tail, invalid, [head|valid_fields])
    end
  end
end
