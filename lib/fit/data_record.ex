defmodule Fit.DataRecord do
  def parse(%{endian: endian, global_msg: _, fields: fields}, data) do
    parse_fields(fields, endian, [], data)
  end

  def parse_fields([], _, fields, data) do
    {fields, data}
  end
  def parse_fields(field_defs, endian, fields, data) do
    [fdef | tail] = field_defs
    {parsed, rest} = parse_field(fdef, endian, data)
    parse_fields(tail, endian, [parsed|fields], rest)
  end

  def parse_field(%{base_num: base_num, field_def_num: field_def_num, size: size}, endian, data) do
    {value, data} = parse_data(base_num, endian, size, data, [])
    {{field_def_num, value}, data}
  end

  def parse_data(_, _, 0, data, value) do
    {value, data}
  end
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
        <<field::signed-little-integer-unit(8)-size(2), rest::binary>> = data
        parse_data(3, endian, size-2, rest, validate_field(field, invalid, value))
      :big ->
        <<field::signed-integer-unit(8)-size(2), rest::binary>> = data
        parse_data(4, endian, size-2, rest, validate_field(field, invalid, value))
    end
  end
  def parse_data(4, endian, size, data, value) do
    invalid = 65535
    case endian do
      :little ->
        <<field::little-integer-unit(8)-size(2), rest::binary>> = data
        parse_data(4, endian, size-2, rest, validate_field(field, invalid, value))
      :big ->
        <<field::integer-unit(8)-size(2), rest::binary>> = data
        parse_data(4, endian, size-2, rest, validate_field(field, invalid, value))
    end
  end
  def parse_data(5, endian, size, data, value) do
    invalid = 2147483647
    case endian do
      :little ->
        <<field::signed-little-integer-unit(8)-size(4), rest::binary>> = data
        parse_data(5, endian, size-4, rest, validate_field(field, invalid, value))
      :big ->
        <<field::signed-integer-unit(8)-size(4), rest::binary>> = data
        parse_data(5, endian, size-4, rest, validate_field(field, invalid, value))
    end
  end
  def parse_data(6, endian, size, data, value) do
    invalid = 4294967295
    case endian do
      :little ->
        <<field::little-integer-unit(8)-size(4), rest::binary>> = data
        parse_data(6, endian, size-4, rest, validate_field(field, invalid, value))
      :big ->
        <<field::integer-unit(8)-size(4), rest::binary>> = data
        parse_data(6, endian, size-4, rest, validate_field(field, invalid, value))
    end
  end
  def parse_data(7, endian, size, data, value) do
    <<field::utf8, rest::binary>> = data
    parse_data(7, endian, size-1, rest, validate_field(field, 0, value))
  end
  def parse_data(8, endian, size, data, value) do
    invalid = 4294967295
    case endian do
      :little ->
        <<field::little-float-unit(8)-size(4), rest::binary>> = data
        parse_data(8, endian, size-4, rest, validate_field(field, invalid, value))
      :big ->
        <<field::float-unit(8)-size(4), rest::binary>> = data
        parse_data(8, endian, size-4, rest, validate_field(field, invalid, value))
    end
  end
  def parse_data(9, endian, size, data, value) do
    invalid = 18446744073709551615
    case endian do
      :little ->
        <<field::signed-little-float-unit(8)-size(8), rest::binary>> = data
        parse_data(9, endian, size-8, rest, validate_field(field, invalid, value))
      :big ->
        <<field::signed-float-unit(8)-size(8), rest::binary>> = data
        parse_data(9, endian, size-8, rest, validate_field(field, invalid, value))
    end
  end
  def parse_data(10, endian, size, data, value) do
    <<field, rest::binary>> = data
    parse_data(10, endian, size-1, rest, validate_field(field, 0, value))
  end
  def parse_data(11, endian, size, data, value) do
    invalid = 0
    case endian do
      :little ->
        <<field::little-integer-unit(8)-size(2), rest::binary>> = data
        parse_data(11, endian, size-2, rest, validate_field(field, invalid, value))
      :big ->
        <<field::integer-unit(8)-size(2), rest::binary>> = data
        parse_data(11, endian, size-2, rest, validate_field(field, invalid, value))
    end
  end
  def parse_data(12, endian, size, data, value) do
    invalid = 0
    case endian do
      :little ->
        <<field::little-integer-unit(8)-size(4), rest::binary>> = data
        parse_data(12, endian, size-4, rest, validate_field(field, invalid, value))
      :big ->
        <<field::integer-unit(8)-size(4), rest::binary>> = data
        parse_data(12, endian, size-4, rest, validate_field(field, invalid, value))
    end
  end
  def parse_data(13, endian, size, data, value) do
    <<field, rest::binary>> = data
    parse_data(0, endian, size-1, rest, validate_field(field, 0xFF, value))
  end
  def parse_data(14, endian, size, data, value) do
    invalid = 0x7FFFFFFFFFFFFFFF
    case endian do
      :little ->
        <<field::little-signed-integer-unit(8)-size(8), rest::binary>> = data
        parse_data(14, endian, size-8, rest, validate_field(field, invalid, value))
      :big ->
        <<field::integer-signed-unit(8)-size(8), rest::binary>> = data
        parse_data(14, endian, size-8, rest, validate_field(field, invalid, value))
    end
  end
  def parse_data(15, endian, size, data, value) do
    invalid = 0x7FFFFFFFFFFFFFFF
    case endian do
      :little ->
        <<field::little-integer-unit(8)-size(8), rest::binary>> = data
        parse_data(6, endian, size-4, rest, validate_field(field, invalid, value))
      :big ->
        <<field::integer-unit(8)-size(8), rest::binary>> = data
        parse_data(6, endian, size-4, rest, validate_field(field, invalid, value))
    end
  end
  def parse_data(16, endian, size, data, value) do
    <<field::64, rest::binary>> = data
    parse_data(16, endian, size-8, rest, validate_field(field, 0, value))
  end

  def validate_field(field, invalid, values) do
    unless field == invalid do
      values = [field | values]
    end
    values
  end
end
