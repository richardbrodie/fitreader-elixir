require IEx;

defmodule Fit.Message do
  use GenServer

  ## Client API

  def start_link do
    GenServer.start_link(__MODULE__, :ok)
  end

  def queue(msg_pid, record) do
    GenServer.cast(msg_pid, {:queue, record})
  end

  def process(msg_pid) do
    GenServer.call(msg_pid, :process)
  end

  def get(msg_pid, global_num) do
    GenServer.call(msg_pid, {:get, global_num})
  end

  def get_all(msg_pid) do
    GenServer.call(msg_pid, :get_all)
  end

  def get_keys(msg_pid) do
    GenServer.call(msg_pid, :get_keys)
  end

  ## Callbacks

  def init(:ok) do
    {:ok, {%{}, %{}}}
  end

  def handle_cast({:queue, {global_num, data_record}}, {queue, records}) do
    new_queue = Map.update(queue, global_num, [data_record], fn val -> [data_record | val] end)
    {:noreply, {new_queue, records}}
  end

  def handle_call(:process, _from, {queue, _records}) do
    records = queue |> Map.to_list
                    |> Enum.map(&process_records(&1))
                    |> Enum.into(%{})
    {:reply, :ok, {queue, records}}
  end

  def handle_call({:get, global_num}, _from, {queue, records}) do
    candidate = Map.fetch(records, global_num)
    case candidate do
      {:ok, [single_record|[]]} ->
        result = single_record |> Enum.into(%{})
        {:reply, result, {queue, records}}
      {:ok, other} ->
        result = other
                 |> Enum.reverse
                 |> Enum.map(&Enum.into(&1, %{}))
        {:reply, result, {queue, records}}
      :error -> {:reply, :error, {queue, records}}
    end
  end

  def handle_call(:get_all, _from, {queue, records}) do
    {:reply, records, {queue, records}}
  end

  def handle_call(:get_keys, _from, {queue, records}) do
    {:reply, Map.keys(records), {queue, records}}
  end

  ## Private
  defp process_records({global_num, records}) do
    res = records
          |> batch_process_records(global_num, [])
    {global_num, res}
  end

  defp batch_process_records([], _global, records), do: records
  defp batch_process_records([%{fields: fields, dev_fields: dev_fields}|tail], global, records) do
    record = fields
             |> process_fields(global, [])
             |> process_manufacturer
             |> process_sourcetype
             |> process_event
    record = case dev_fields do
      nil -> record
      _ -> dev_fields |> Enum.concat(record)
    end
    batch_process_records(tail, global, [record|records])
  end

  defp process_fields([], _global_num, processed), do: processed
  defp process_fields([{field_num, raw_val}|tail], global_num, processed) do
    field = case Fit.Sdk.Fields.get(global_num, field_num) do
      {name, type, scale, offset} ->
        processed_val = raw_val
                        |> process_type(type)
                        |> process_scale(scale)
                        |> process_offset(offset)
        {name, processed_val}
      _ ->
        {field_num, raw_val}
    end
    process_fields(tail, global_num, [field|processed])
  end

  defp process_type(val, type) do
    case type do
      {:enum, enum_name} ->
        Fit.Sdk.Enums.get(enum_name, val)
      :date_time ->
        adjusted_unix = 631065600 + val
      :local_date_time ->
        adjusted_unix = 631065600 + val
      :coordinates ->
        val * (180 / :math.pow(2,31))
      _ ->
        val
    end
  end

  defp process_scale(val, 0), do: val
  defp process_scale(val, scale) do
    if is_list val do
      Enum.map(val, fn v -> (v * 1.0) / scale end)
    else
      (val * 1.0) / scale
    end
  end

  defp process_offset(val, 0), do: val
  defp process_offset(val, offset) do
    if is_list val do
      Enum.map(val, fn v -> v - offset end)
    else
      val - offset
    end
  end

  defp process_event(record) do
    case record do
      %{event: x} when x in [:rear_gear_change, :front_gear_change] ->
        new_val = record[:data] |> :binary.encode_unsigned(:little) |> :binary.bin_to_list
        %{record | data: new_val}
      _ -> record
    end
  end

  defp process_sourcetype(record) do
    case record do
      %{source_type: :antplus} ->
        %{record | device_type: Fit.Sdk.Enums.get(:antplus_device_type, record[:value])}
      _ -> record
    end
  end

  defp process_manufacturer(record) do
    case record do
      %{manufacturer: m} when m in [:garmin, :dynastream, :dynastream_oem] ->
        %{record | garmin_product: Fit.Sdk.Enums.get(:enum_garmin_product, record[:garmin_product])}
      _ -> record
    end
  end
end
