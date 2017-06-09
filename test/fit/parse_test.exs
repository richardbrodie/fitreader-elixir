defmodule Fit.ParseTest do
  use ExUnit.Case, async: true

  setup do
    {:ok, fit} = File.read('test/2016-04-09-13-19-18.fit')
    {:ok, fit: fit}
  end

  test "read some records", %{fit: fit} do
    {header, rest} = Fit.Header.parse fit # 14:14
    {recordheader, rest} = Fit.RecordHeader.parse rest # 1:15
    assert recordheader.header_type == :definition
    {def_record, rest} = Fit.DefinitionRecord.parse rest # 26:41
    {recordheader, rest} = Fit.RecordHeader.parse rest # 1:42
    assert recordheader.header_type == :data
    {data_record, _rest} = Fit.DataRecord.parse(rest,recordheader)
  end
end
