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
    Agent.start_link(fn -> %{} end, name: :defs)
    {:ok, fit} = File.read('test/2016-04-09-13-19-18.fit')
    {_header, rest} = Fit.Header.parse fit # 14:14
    read_record(rest)
  end

  def read_record(<<>>) do
    IO.puts "done!"
  end
  def read_record(data) do
    {recordheader, rest} = Fit.RecordHeader.parse data
    case recordheader.header_type do
      :definition ->
        {def_record, rest} = Fit.DefinitionRecord.parse rest
        Agent.update(:defs, &Map.put(&1, recordheader.local_message_type, def_record))
      :data ->
        def_record = Agent.get(:defs, &Map.get(&1, recordheader.local_message_type))
        {_data_record, rest} = Fit.DataRecord.parse(def_record, rest)
      :timestamp ->
        IO.puts "timestamp"
    end
    read_record(rest)
  end
end
