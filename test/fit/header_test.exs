defmodule Fit.HeaderTest do
  use ExUnit.Case, async: true

  setup do
    raw_data = <<14, 16, 116, 6, 51, 92, 1, 0, 46, 70, 73, 84, 213, 14>>
    {header,_rest} = Fit.Header.parse raw_data
    {:ok, header: header}
  end

  test "parses valid header", %{header: header} do
    assert header.filesize == 14
    assert header.protocol == 16
    assert header.profile_version == 1652
    assert header.num_record_bytes == 89139
    assert header.crc == 3797
  end
end
