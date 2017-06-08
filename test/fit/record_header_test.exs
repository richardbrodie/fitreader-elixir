defmodule Fit.RecordHeaderTest do
  use ExUnit.Case, async: true

  setup do
    raw_data = <<64, 16, 116, 6, 51, 92, 1, 0, 46, 70, 73, 84, 213, 14>>
    {recordheader,_rest} = Fit.RecordHeader.parse raw_data
    {:ok, recordheader: recordheader}
  end

  test "parses valid header", %{recordheader: recordheader} do
    assert recordheader.header_type == :definition
    assert recordheader.message_type_specific == 0
    assert recordheader.local_message_type == 0
  end
end
