defmodule Fit.DataRecordTest do
  use ExUnit.Case, async: true

  setup do
    # <<_::binary-size(41), rest::binary>> = File.read!('test/2016-04-09-13-19-18.fit')
    raw_data = <<71, 146, 153, 232, 54, 153, 107, 49, 255, 255, 255, 255, 1, 0, 44, 7, 255,
  255, 4, 65, 0, 0, 49, 0, 2, 0, 2, 132, 1, 1, 2, 1, 188, 2, 255, 66, 0, 0, 21,
  0, 5, 253, 4, 134, 3, 4, 134, 0, 1, 0, 1, 1, 0, 4, 1, 2, 2, 54, 153, 107, 49, 0, 0, 0, 0, 0, 0, 0, 67, 0, 0, 23, 0,
  18, 253, 4, 134, 3, 4, 140, 7, 4, 134, 8, 4, 134, 15, 4, 134, 16, 4, 134, 24,
  4, 140, 2, 2, 132, 4, 2>>
    fields = [
      %{base_num: 0, endianness: 0, field_def_num: 0, size: 1},
      %{base_num: 4, endianness: 1, field_def_num: 5, size: 2},
      %{base_num: 4, endianness: 1, field_def_num: 2, size: 2},
      %{base_num: 4, endianness: 1, field_def_num: 1, size: 2},
      %{base_num: 6, endianness: 1, field_def_num: 7, size: 4},
      %{base_num: 6, endianness: 1, field_def_num: 4, size: 4},
      %{base_num: 12, endianness: 1, field_def_num: 3, size: 4}
    ]

    {result, _rest} = Fit.DataRecord.parse(%{endian: :big, global_msg: 0, num_fields: 7, field_defs: fields}, raw_data)
    {:ok, result: result}
  end

  test "parses data field", %{result: result} do
    assert  %Fit.DataRecord{
      fields: [
        {3, [134217476]},
        {4, [4278255660]},
        {7, [838860799]},
        {1, [39275]},
        {2, [59446]},
        {5, [37529]},
        {0, 'G'}],
      global_num: 0
    } == result
  end
end
