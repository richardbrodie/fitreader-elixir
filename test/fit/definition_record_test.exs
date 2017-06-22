defmodule Fit.DefinitionRecordTest do
  use ExUnit.Case, async: true

  setup do
    # <<_::binary-size(41), rest::binary>> = File.read!('test/2016-04-09-13-19-18.fit')
    raw_data = <<0, 0, 0, 0, 7, 3, 4, 140, 4, 4, 134, 7, 4, 134, 1, 2, 132, 2, 2, 132, 5, 2, 132, 0, 1, 0>>
    {def_record, _rest} = Fit.DefinitionRecord.parse raw_data
    {:ok, def_record: def_record}
  end

  test "parses valid header", %{def_record: def_record} do
    assert def_record.endian == :little
    assert def_record.global_msg == 0
    assert def_record.num_fields == 7
    assert length(def_record.field_defs) == 7
    # fields: [
    #   %{base_num: 0, endianness: 0, field_def_num: 0, size: 1},
    #   %{base_num: 4, endianness: 1, field_def_num: 5, size: 2},
    #   %{base_num: 4, endianness: 1, field_def_num: 2, size: 2},
    #   %{base_num: 4, endianness: 1, field_def_num: 1, size: 2},
    #   %{base_num: 6, endianness: 1, field_def_num: 7, size: 4},
    #   %{base_num: 6, endianness: 1, field_def_num: 4, size: 4},
    #   %{base_num: 12, endianness: 1, field_def_num: 3, size: 4}
    # ]
  end
end
