defmodule Fit do
  @moduledoc """
  Documentation for Fit.
  """
  def read(path) do
    case File.read(path) do
      {:ok, fit} ->
        {:ok, msg_pid} = Fit.Message.start_link
        {:ok, reg_pid} = Agent.start_link(fn -> Map.new end)
        {:ok, dev_pid} = Agent.start_link(fn -> Map.new end)

        {header, rest} = Fit.Header.parse fit
        stop_at = byte_size(fit) - (header[:num_record_bytes] + 14)
        read_records(rest, stop_at, {msg_pid, reg_pid, dev_pid})

        Agent.stop(reg_pid)
        Agent.stop(dev_pid)
        {:ok, msg_pid}
      _ ->
        {:error}
    end
  end

  def digest(pid) do
    Fit.Message.get_keys(pid)
    |> Enum.reduce(%{}, fn k, acc -> Map.put(acc, k, Fit.Sdk.Messages.get(k)) end)
  end

  def record(pid, number) do
    Fit.Message.get(pid, number)
  end

  defp read_records(<<>>, _stop_at, _pids), do: :ok
  defp read_records(data, stop_at, {msg_pid, reg_pid, dev_pid}) do
    {recordheader, rest} = Fit.RecordHeader.parse(data)
    rest = case recordheader.header_type do
      :definition ->
        read_definition(rest, recordheader, {dev_pid, reg_pid})
      :data ->
        read_data(rest, recordheader.local_message_type, {msg_pid, reg_pid, dev_pid})
      :timestamp ->
        rest
    end
    unless byte_size(rest) == stop_at do
      read_records(rest, stop_at, {msg_pid, reg_pid, dev_pid})
    end
  end

  defp read_definition(data, header, {dev_pid, reg_pid}) do
    {def_record, rest} = Fit.DefinitionRecord.parse(data, header.message_type_specific, dev_pid)
    Agent.update(reg_pid, &Map.put(&1, header.local_message_type, def_record))
    rest
  end

  defp read_data(data, local_message_type, {msg_pid, reg_pid, dev_pid}) do
    # get definition
    def_record = Agent.get(reg_pid, &Map.get(&1, local_message_type))

    # process record
    {data_record, rest} = Fit.DataRecord.parse(def_record, data)

    # if record is a dev_field definition store it seperately
    if def_record.global_msg == 206 do
      dev_field = make_developer_field(data_record.fields, Map.new)
      Agent.update(dev_pid, &Map.put(&1, dev_field.dev_data_idx, dev_field))
    else
      Fit.Message.process(msg_pid, {def_record.global_msg, data_record})
    end
    rest
  end

  defp make_developer_field([], map), do: map
  defp make_developer_field(data_record, map) do
    [entry | tail] = data_record
    new_map = case entry do
      {0, [val]} -> Map.put(map, :dev_data_idx, val)
      {1, [val]} -> Map.put(map, :field_def_num, val)
      {2, [val]} -> Map.put(map, :base_type_id, val)
      {3, [val]} -> Map.put(map, :field_name, val)
      {8, [val]} -> Map.put(map, :units, val)
      _ -> map
    end
    make_developer_field(tail, new_map)
  end
end
