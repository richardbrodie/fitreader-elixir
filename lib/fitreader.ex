defmodule Fit do
  @moduledoc """
  Documentation for Fit.
  """
  def read(path) do
    {:ok, fit} = File.read(path)
    {:ok, reg_pid} = Fit.RecordRegistry.start_link
    {header, rest} = Fit.Header.parse fit
    stop_at =  byte_size(fit) - (header[:num_record_bytes] + 14)
    read_record(rest, stop_at, reg_pid)
    msg_pid = Fit.RecordRegistry.flush(reg_pid)
    :ok = Fit.RecordRegistry.stop(reg_pid)
    msg_pid
  end

  def read_record(<<>>, _stop_at, _reg_pid), do: :ok
  def read_record(data, stop_at, reg_pid) do
    {recordheader, rest} = Fit.RecordHeader.parse data
    case recordheader.header_type do
      :definition ->
        {def_record, rest} = Fit.DefinitionRecord.parse rest
        Fit.RecordRegistry.add_definition(reg_pid, recordheader.local_message_type, def_record)
      :data ->
        {:ok, def_record} = Fit.RecordRegistry.get_definition(reg_pid, recordheader.local_message_type)
        {data_record, rest} = Fit.DataRecord.parse(def_record, rest)
        Fit.RecordRegistry.add_datarecord(reg_pid, recordheader.local_message_type, data_record)
      :timestamp ->
        :timestamp
    end
    unless byte_size(rest) == stop_at do
      read_record(rest, stop_at, reg_pid)
    end
  end
end
