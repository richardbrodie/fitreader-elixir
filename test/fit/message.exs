defmodule Fit.MessageTest do
  use ExUnit.Case, async: true

  setup do
    def_record = %{endian: :big, global_msg: 0, num_fields: 7, field_defs: [
      %{base_num: 0, endianness: 0, field_def_num: 0, size: 1},
      %{base_num: 4, endianness: 1, field_def_num: 5, size: 2},
      %{base_num: 4, endianness: 1, field_def_num: 2, size: 2},
      %{base_num: 4, endianness: 1, field_def_num: 1, size: 2},
      %{base_num: 6, endianness: 1, field_def_num: 7, size: 4},
      %{base_num: 6, endianness: 1, field_def_num: 4, size: 4},
      %{base_num: 12, endianness: 1, field_def_num: 3, size: 4}
    ]}
    data_record = %Fit.DataRecord{
      fields: [
        {3, [134217476]},
        {4, [4278255660]},
        {7, [838860799]},
        {1, [39275]},
        {2, [59446]},
        {5, [37529]},
        {0, 'G'}],
      global_num: 0
    }
    {:ok, def_record: def_record, data_record: data_record}
  end

  test "parses with sdk", %{def_record: def_record, data_record: data_record} do
    global_num = old_def.global_msg
    sdk_fields = Fit.Sdk.Fields.get(global_num)
  end
