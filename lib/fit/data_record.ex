defmodule Fit.DataRecord do
  defstruct [:global_num, :fields]
  def parse(%{endian: endian, global_msg: global, field_defs: fields}, data) do
    {fields, rest} = parse_fields(fields, endian, [], data)
    {%Fit.DataRecord{global_num: global, fields: fields}, rest}
  end

  def parse_fields([], _, fields, data), do: {fields, data}
  def parse_fields(field_defs, endian, fields, data) do
    [%{base_num: base_num, field_def_num: field_def_num, size: size} | tail] = field_defs
    case parse_data(base_num, endian, size, data, []) do
      {[], rest} ->
        parse_fields(tail, endian, fields, rest)
      {value, rest} ->
        parse_fields(tail, endian, [{field_def_num, value}|fields], rest)
    end
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
    <<raw::binary-size(size), rest::binary>> = data
    field = Enum.filter(String.to_charlist(raw), fn x -> x > 0 end)
    parse_data(7, endian, 0, rest, [field|value])
  end
  def parse_data(8, endian, size, data, value) do
    invalid = 4294967295
    case endian do
      :little ->
        <<field::little-float-size(32), rest::binary>> = data
      :big ->
        <<field::float-size(32), rest::binary>> = data
    end
    parse_data(8, endian, size-4, rest, validate_field(field, invalid, value))
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

  def validate_field(field, invalid, values) do
    unless field == invalid do
      values = [field | values]
    end
    values
  end
end
