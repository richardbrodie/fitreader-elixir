defmodule Fit.Message do
  use GenServer

  ## Client API

  def start_link do
    GenServer.start_link(__MODULE__, :ok)
  end

  def process(msg_pid, data) do
    GenServer.cast(msg_pid, {:process, data})
  end

  def flush(msg_pid, data_records) do
    GenServer.call(msg_pid, {:process_all, data_records})
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
    {:ok, %{}}
  end

  def handle_cast({:process, data_records}, state) do
    {global_num, messages} = process_records(data_records)
    new_state = Map.update(state, global_num, messages, fn val -> val ++ messages end)
    {:noreply, new_state}
  end

  def handle_call({:process_all, grouped_data_records}, _from, state) do
    new_state = grouped_data_records
              |> Enum.map(&Task.async(fn ->
                   process_records(&1)
                 end))
              |> Enum.map(&Task.await/1)
              |> Enum.reduce(state, &update_state/2)
    {:reply, :ok, new_state}
  end

  def handle_call({:get, global_num}, _from, state) do
    case Map.fetch(state, global_num) do
      {:ok, [result|[]]} -> {:reply, to_map(result), state}
      {:ok, [head|tail]} ->
        result = [head|tail] |> Enum.map(&to_map(&1))
        {:reply, result, state}
      :error -> {:reply, :error, state}
    end
  end

  def handle_call(:get_all, _from, state) do
    {:reply, state, state}
  end

  def handle_call(:get_keys, _from, state) do
    {:reply, Map.keys(state), state}
  end

  ## Private

  defp to_map(record) do
    record |> Enum.reduce(%{}, fn {k,v}, acc -> Map.put(acc, k, v) end)
  end

  defp update_state({global_num, records}, state) do
    Map.update(state, global_num, records, fn val -> val ++ records end)
  end

  defp process_records(records) do
    [%{global_num: global_num}|_records] = records
    res = records
            |> Enum.map(&Task.async(fn ->
                 process_record(&1)
               end))
            |> Enum.map(&Task.await/1)
    {global_num, res}
  end

  defp process_record(%{global_num: global_num, fields: fields}) do
    process_fields(fields, global_num)
    |> process_manufacturer
    |> process_sourcetype
    |> process_event
    |> Enum.filter(fn x -> x != nil end)
  end

  defp process_fields(fields, global_num) do
    fields
    |> Enum.map(&Task.async(fn ->
         process_field(&1, global_num)
       end))
    |> Enum.map(&Task.await/1)
  end

  defp process_field({field_num, field_val}, global_num) do
    case Fit.Sdk.Fields.get(global_num, field_num) do
      {name, type, scale, offset} ->
        val = field_val
              |> process_type(type)
              |> process_scale(scale)
              |> process_offset(offset)
              |> process_list
        {name, val}
      nil ->
        nil
    end
  end

  defp process_type([val|rest], type) do
    case Atom.to_string(type) do
      "enum" <> _rest ->
        Fit.Sdk.Enums.get(type, val)
      "date_time" ->
        {:ok, t} = DateTime.from_unix(631065600 + val)
        DateTime.to_string(t)
      "local_date_time" ->
        {:ok, t} = DateTime.from_unix(631058400 + val)
        DateTime.to_string(t)
      "coordinates" ->
        val * (180 / :math.pow(2,31))
      _ ->
        [val|rest]
    end
  end

  defp process_scale(val, scale) do
    if scale > 0 do
      Enum.map(val, fn v -> (v * 1.0) / scale end)
    else
      val
    end
  end

  defp process_offset(val, offset) do
    if offset > 0 do
      Enum.map(val, fn v -> v - offset end)
    else
      val
    end
  end

  defp process_list(val) do
    case val do
      [v|[]] -> v
      _ -> val
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
