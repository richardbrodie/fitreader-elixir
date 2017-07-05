defmodule Fit.Message do
  use GenServer

  ## Client API

  def start_link do
    GenServer.start_link(__MODULE__, :ok, name: :messages)
  end

  def process(data) do
    GenServer.cast(:messages, {:process, data})
  end

  def get(global_num) do
    GenServer.call(:messages, {:get, global_num})
  end

  ## Callbacks

  def init(:ok) do
    {:ok, %{}}
  end

  def handle_cast({:process, data_records}, state) do
    [%{global_num: g_num}|_records] = data_records
    messages = make_messages(data_records, [])
    new_state = Map.update(state, g_num, messages, fn val -> [messages | val] end)
    {:noreply, new_state}
  end

  def handle_call({:get, global_num}, _from, state) do
    case Map.fetch(state, global_num) do
      {:ok, result} -> {:reply, result, state}
      :error -> {:reply, :error, state}
    end
  end

  def make_messages([], state), do: state
  def make_messages([%{global_num: g_num, fields: fields}|records], state) do
    record = process_fields(g_num, fields, [])
          |> process_manufacturer
          |> process_sourcetype
          |> process_event
    make_messages(records, [record|state])
  end

  ## Private

  defp process_fields(_, [], state), do: state
  defp process_fields(global_num, [{field_num, field_val}|fields], state) do
    new_state = case Fit.Sdk.Fields.get(global_num, field_num) do
      nil ->
        state
      {name, type, scale, offset} ->
        val = field_val |> process_type(type)
                        |> process_scale(scale)
                        |> process_offset(offset)
        [{name, val}|state]
    end
    process_fields(global_num, fields, new_state)
  end

  defp process_type([], _type), do: []
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
