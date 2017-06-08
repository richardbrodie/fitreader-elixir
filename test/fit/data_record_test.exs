defmodule Fit.DataRecordTest do
  use ExUnit.Case, async: true

  setup do
    <<_::binary-size(41), rest::binary>> = File.read!('test/2016-04-09-13-19-18.fit')
    # raw_data = <<0, 0, 0, 0, 7, 3, 4, 140, 4, 4, 134, 7, 4, 134, 1, 2, 132, 2, 2, 132, 5, 2, 132, 0, 1, 0>>
    # {data_record, _rest} = Fit.DataRecord.parse rest
    {:ok, data_record: 123}
  end

  test "parses valid header", %{data_record: data_record} do
    # IO.inspect data_record
    # assert def_record.endian == :little
    # assert def_record.global_msg == 0
    # assert def_record.num_fields == 7
    # assert length(def_record.fields) == 7
  end
end
