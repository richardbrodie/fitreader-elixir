defmodule Fit.RecordRegistry do
  use GenServer

  #
  # Client API
  #

  def start_link do
    GenServer.start_link(__MODULE__, :ok, name: :records)
  end

  def add_definition(local_type, def_record) do
    GenServer.cast(:records, {:add_definition, local_type, def_record})
  end
  def add_datarecord(local_type, data) do
    GenServer.cast(:records, {:add_datarecord, local_type, data})
  end
  def flush do
    GenServer.cast(:records, :flush)
  end

  def get_definition(id) do
    GenServer.call(:records, {:get_def, id})
  end
  # def get_datarecords(id) do
  #   GenServer.call(:records, {:get_data, id})
  # end

  #
  # Callbacks
  #

  # init

  def init(:ok) do
    {:ok, {%{}, %{}}}
  end

  # cast

  def handle_cast({:add_definition, local_type, def_record}, {def_records, data_records}) do
    case Map.has_key?(def_records, local_type) do
      true ->
        {_old_def, def_records} = Map.get_and_update(def_records, local_type, fn c -> {c, def_record} end)
        {data, data_records} = Map.pop(data_records, local_type)
        Fit.Message.process(data)
      false ->
        def_records = Map.put(def_records, local_type, def_record)
    end
    {:noreply, {def_records, data_records}}
  end

  def handle_cast({:add_datarecord, local_type, data}, {def_records, data_records}) do
    case Map.has_key?(data_records, local_type) do
      true ->
        data_records = Map.update(data_records, local_type, [data], fn d -> [data | d] end)
      false ->
        data_records = Map.put(data_records, local_type, [data])
    end
    {:noreply, {def_records, data_records}}
  end

  def handle_cast(:flush, {def_records, data_records}) do
    def_list = Map.to_list(def_records)
    flush(def_list, data_records)
    {:noreply, {%{}, %{}}}
  end

  # call

  def handle_call({:get_def, id}, _from, {def_records, data_records}) do
    {:reply, Map.fetch(def_records, id), {def_records, data_records}}
  end

  # def handle_call({:get_data, id}, _from, {def_records, data_records}) do
  #   {:reply, Map.fetch(data_records, id), {def_records, data_records}}
  # end

  #
  # Private
  #

  defp flush(def_records, data_records) do
    Enum.each(def_records, fn {local_type, _def_record} ->
      data = Map.get(data_records, local_type)
      Fit.Message.process(data)
    end)
  end
end
