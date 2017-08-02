require IEx;

defmodule Fit.Message do
  use GenServer

  ## Client API

  def start_link do
    GenServer.start_link(__MODULE__, :ok)
  end

  def process(msg_pid, data) do
    GenServer.call(msg_pid, {:process, data})
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

  def handle_call({:process, {global_num, data_record}}, _from, state) do
    record = process_record({global_num, data_record})
    new_state = Map.update(state, global_num, record, fn val -> val ++ record end)
    {:reply, :ok, new_state}
  end

  def handle_call({:get, global_num}, _from, state) do
    case Map.fetch(state, global_num) do
      {:ok, [result|[]]} -> {:reply, to_map(result), state}
      {:ok, other} ->
        result = [other] |> Enum.map(&to_map(&1))
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

  defp process_record(data) do
    record = process_fields(data)
              |> process_manufacturer
              |> process_sourcetype
              |> process_event
              |> Enum.filter(fn x -> x != nil end)

    case data do
      {_global_num, %{dev_fields: dev_fields}} ->
        Enum.map(dev_fields, fn {k,v} -> {k, process_list(v)} end) |> Enum.concat(record)
      _ -> record
    end
  end


  # defp process_record(record) do
  #   dev_fields = case Map.get(record, :dev_fields) do
  #     nil -> []
  #     dev_fields -> Enum.map(dev_fields, fn {k,v} -> {k, process_list(v)} end)
  #   end
  #   process_fields(record)
  #           |> process_manufacturer
  #           |> process_sourcetype
  #           |> process_event
  #           |> Enum.filter(fn x -> x != nil end)
  #           |> Enum.concat(dev_fields)
  # end

  defp process_fields({global_num, %{fields: fields}}) do
    # %{fields: fields, global_num: global_num} = record
    fields |> Enum.map(fn f -> process_field(f, global_num) end)
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
        val = field_val |> process_list
        {field_num, val}
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
