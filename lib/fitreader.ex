defmodule Fit do
  @moduledoc """
  Documentation for Fit.
  """

  @doc """
  Hello world.

  ## Examples

      iex> Fit.hello
      :world

  """
  def hello do
    :world
  end

  def read do
    # :ets.new(:defs_registry, [:named_table])
    {:ok, reg_pid} = Fit.RecordRegistry.start_link
    {:ok, msg_pid} = Fit.Message.start_link
    {:ok, fit} = File.read('test/2016-04-09-13-19-18.fit')
    {_header, rest} = Fit.Header.parse fit # 14:14
    read_record(rest, {reg_pid, msg_pid})
  end

  def read_record(<<>>, {_reg_pid, _msg_pid}) do
    IO.puts "done!"
  end
  def read_record(data, {reg_pid, msg_pid}) do
    {recordheader, rest} = Fit.RecordHeader.parse data
    case recordheader.header_type do
      :definition ->
        {def_record, rest} = Fit.DefinitionRecord.parse rest
        Fit.RecordRegistry.add_definition(reg_pid, {recordheader.local_message_type, def_record})
      :data ->
        {:ok, def_record} = Fit.RecordRegistry.get_definition(reg_pid, recordheader.local_message_type)
        {data_record, rest} = Fit.DataRecord.parse(def_record, rest)
        Fit.RecordRegistry.add_datarecord(reg_pid, {recordheader.local_message_type, data_record})
      :timestamp ->
        IO.puts "timestamp"
    end
    read_record(rest, {reg_pid, msg_pid})
  end
end
