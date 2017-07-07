defmodule Fit do
  @moduledoc """
  Documentation for Fit.
  """

  @doc """
  Hello world.
  """
  def hello do
    :world
  end

  def read do
    {:ok, _reg_pid} = Fit.RecordRegistry.start_link
    {:ok, _msg_pid} = Fit.Message.start_link
    {:ok, fit} = File.read('test/2016-04-09-13-19-18.fit')
    {_header, rest} = Fit.Header.parse fit # 14:14
    read_record(rest)
    Fit.RecordRegistry.flush
    Map.keys(Fit.Message.get_all)
  end

  def read_record(<<>>), do: :ok
  def read_record(data) do
    {recordheader, rest} = Fit.RecordHeader.parse data
    case recordheader.header_type do
      :definition ->
        {def_record, rest} = Fit.DefinitionRecord.parse rest
        Fit.RecordRegistry.add_definition(recordheader.local_message_type, def_record)
      :data ->
        {:ok, def_record} = Fit.RecordRegistry.get_definition(recordheader.local_message_type)
        {data_record, rest} = Fit.DataRecord.parse(def_record, rest)
        Fit.RecordRegistry.add_datarecord(recordheader.local_message_type, data_record)
      :timestamp ->
        :timestamp
    end
    read_record(rest)
  end
end
