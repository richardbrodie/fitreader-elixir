defmodule Fit.DataRecord do
  def parse(data, definition) do
    d = <<71, 146, 153, 232, 54, 153, 107, 49, 255, 255, 255, 255, 1, 0, 44, 7, 255,
  255, 4, 65, 0, 0, 49, 0, 2, 0, 2, 132, 1, 1, 2, 1, 188, 2, 255, 66, 0, 0, 21,
  0, 5, 253, 4, 134, 3, 4, 134, 0, 1, 0>>
  # %{base_num: 4, endianness: 1, field_def_num: 1, size: 2}
  end

  # def parse_data_field(data, field_defs, fields) do
  #   [field_def | field_defs] = field_defs
  #   case field_def do
  #
  #   end
  # end
  #
  # def parse_data_field(rest, [], fields) do
  #   {fields, rest}
  # end

  def parse_data_field(%{base_num: base, endianness: :little, field_def_num: def_num, size: size}, data) do
    case base do
      0 -> <<field, rest::binary>> = data
      1 -> <<field::signed-integer, rest::binary>> = data
      2 -> <<field, rest::binary>> = data
      3 -> <<field::signed-little-integer-unit(8)-size(2), rest::binary>> = data
      3 -> <<field::little-integer-unit(8)-size(2), rest::binary>> = data
    end
  end
  def parse_data_field(%{base_num: base, endianness: :big, field_def_num: def_num, size: size}, data) do
  end

  # def parse_data_field(data, %{base_num: 0}) do
  #   <<field, rest::binary>> = data
  # end
  # def parse_data_field(data, %{base_num: 1}) do
  #   <<field::signed-integer, rest::binary>> = data
  # end
  # def parse_data_field(data, %{base_num: 2}) do
  #   <<field, rest::binary>> = data
  # end
  # def parse_data_field(data, %{base_num: 3, endian: endian}) do
  #   case endian do
  #     :little -> <<field::signed-little-integer-unit(8)-size(2), rest::binary>> = data
  #     :big -> <<field::signed-integer-unit(8)-size(2), rest::binary>> = data
  #   end
  # end
  # def parse_data_field(data, %{base_num: 4, endian: endian}) do
  #   case endian do
  #     :little -> <<field::little-integer-unit(8)-size(2), rest::binary>> = data
  #     :big -> <<field::integer-unit(8)-size(2), rest::binary>> = data
  #   end
  # end
  # def parse_data_field(data, %{base_num: 5, endian: endian}) do
  # end
  # def parse_data_field(data, %{base_num: 6, endian: endian}) do
  # end
  # def parse_data_field(data, %{base_num: 7}) do
  # end
  # def parse_data_field(data, %{base_num: 8, endian: endian}) do
  # end
  # def parse_data_field(data, %{base_num: 9, endian: endian}) do
  # end
  # def parse_data_field(data, %{base_num: 10}) do
  # end
  # def parse_data_field(data, %{base_num: 11}) do
  # end
  # def parse_data_field(data, %{base_num: 12}) do
  # end
  # def parse_data_field(data, %{base_num: 13}) do
  # end
  # def parse_data_field(data, %{base_num: 14}) do
  # end
  # def parse_data_field(data, %{base_num: 15}) do
  # end
  # def parse_data_field(data, %{base_num: 16}) do
  # end
end
