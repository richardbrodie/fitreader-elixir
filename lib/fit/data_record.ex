defmodule Fit.DataRecord do
  defstruct [:global_num, :fields]
  def parse(%{endian: endian, global_msg: global, field_defs: field_defs}, data) do
    {fields, rest} = parse_fields(field_defs, endian, [], data)
    {%Fit.DataRecord{global_num: global, fields: fields}, rest}
  end

  def parse_fields([], _, fields, data), do: {fields, data}
  def parse_fields(_, _, fields, <<>>), do: {fields, <<>>}
  def parse_fields(field_defs, endian, fields, data) do
    [%{base_num: base_num, field_def_num: field_def_num, size: size} | tail] = field_defs
    {result, rest} = parse_data(base_num, endian, size, data, [])
    new_fields = case result do
      [] -> fields
      value -> [{field_def_num, value}|fields]
    end
    parse_fields(tail, endian, new_fields, rest)
  end

  def parse_data(_, _, 0, data, value), do: {value, data}
  def parse_data(0, endian, size, data, value) do
    <<field, rest::binary>> = data
    parse_data(0, endian, size-1, rest, validate_field(field, 255, value))
  end
  def parse_data(1, endian, size, data, value) do
    <<field::signed-integer, rest::binary>> = data
    parse_data(1, endian, size-1, rest, validate_field(field, 127, value))
  end
  def parse_data(2, endian, size, data, value) do
    <<field, rest::binary>> = data
    parse_data(2, endian, size-1, rest, validate_field(field, 255, value))
  end
  def parse_data(3, endian, size, data, value) do
    invalid = 32767
    case endian do
      :little ->
        <<field::signed-little-integer-size(16), rest::binary>> = data
      :big ->
        <<field::signed-integer-size(16), rest::binary>> = data
    end
    parse_data(4, endian, size-2, rest, validate_field(field, invalid, value))
  end
  def parse_data(4, endian, size, data, value) do
    invalid = 65535
    case endian do
      :little ->
        <<field::little-integer-size(16), rest::binary>> = data
      :big ->
        <<field::integer-size(16), rest::binary>> = data
    end
    parse_data(4, endian, size-2, rest, validate_field(field, invalid, value))
  end
  def parse_data(5, endian, size, data, value) do
    invalid = 2147483647
    case endian do
      :little ->
        <<field::signed-little-integer-size(32), rest::binary>> = data
      :big ->
        <<field::signed-integer-size(32), rest::binary>> = data
    end
    parse_data(5, endian, size-4, rest, validate_field(field, invalid, value))
  end
  def parse_data(6, endian, size, data, value) do
    invalid = 4294967295
    case endian do
      :little ->
        <<field::little-integer-size(32), rest::binary>> = data
      :big ->
        <<field::integer-size(32), rest::binary>> = data
    end
    parse_data(6, endian, size-4, rest, validate_field(field, invalid, value))
  end
  def parse_data(7, endian, size, data, value) do
    <<field::binary-size(size), rest::binary>> = data
    parse_data(7, endian, 0, rest, [field|value])
  end
  def parse_data(8, endian, size, data, value) do
    invalid = 4294967295
    case valid?(data, invalid, size) do
      {:ok, data} ->
        case endian do
          :little ->
            <<field::signed-little-float-size(32), rest::binary>> = data
          :big ->
            <<field::signed-float-size(32), rest::binary>> = data
        end
        parse_data(8, endian, size-4, rest, validate_field(field, invalid, value))
      {:error, rest} ->
        parse_data(8, endian, size-4, rest, value)
    end
  end
  def parse_data(9, endian, size, data, value) do
    invalid = 18446744073709551615
    case endian do
      :little ->
        <<field::signed-little-float-size(64), rest::binary>> = data
      :big ->
        <<field::signed-float-size(64), rest::binary>> = data
    end
    parse_data(9, endian, size-8, rest, validate_field(field, invalid, value))
  end
  def parse_data(10, endian, size, data, value) do
    <<field, rest::binary>> = data
    parse_data(10, endian, size-1, rest, validate_field(field, 0, value))
  end
  def parse_data(11, endian, size, data, value) do
    invalid = 0
    case endian do
      :little ->
        <<field::little-integer-size(16), rest::binary>> = data
      :big ->
        <<field::integer-size(16), rest::binary>> = data
    end
    parse_data(11, endian, size-2, rest, validate_field(field, invalid, value))
  end
  def parse_data(12, endian, size, data, value) do
    invalid = 0
    case endian do
      :little ->
        <<field::little-integer-size(32), rest::binary>> = data
      :big ->
        <<field::integer-size(32), rest::binary>> = data
    end
    parse_data(12, endian, size-4, rest, validate_field(field, invalid, value))
  end
  def parse_data(13, endian, size, data, value) do
    <<field, rest::binary>> = data
    parse_data(13, endian, size-1, rest, validate_field(field, 0xFF, value))
  end
  def parse_data(14, endian, size, data, value) do
    invalid = 0x7FFFFFFFFFFFFFFF
    case endian do
      :little ->
        <<field::little-signed-integer-size(64), rest::binary>> = data
      :big ->
        <<field::signed-integer-size(64), rest::binary>> = data
    end
    parse_data(14, endian, size-8, rest, validate_field(field, invalid, value))
  end
  def parse_data(15, endian, size, data, value) do
    invalid = 0xFFFFFFFFFFFFFFFF
    case endian do
      :little ->
        <<field::little-integer-size(64), rest::binary>> = data
      :big ->
        <<field::integer-size(64), rest::binary>> = data
    end
    parse_data(15, endian, size-8, rest, validate_field(field, invalid, value))
  end
  def parse_data(16, endian, size, data, value) do
    invalid = 0x0
    case endian do
      :little ->
        <<field::little-integer-size(64), rest::binary>> = data
      :big ->
        <<field::integer-size(64), rest::binary>> = data
    end
    parse_data(16, endian, size-8, rest, validate_field(field, invalid, value))
  end

  defp valid?(data, invalid, size) do
    case data do
      <<^invalid::unit(8)-size(size), rest::binary>> -> {:error, rest}
      _ -> {:ok, data}
    end
  end

  defp validate_field(field, invalid, values) do
    unless field == invalid do
      values = [field | values]
    end
    values
  end
end
