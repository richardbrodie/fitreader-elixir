defmodule Fit.RecordRegistry do
  use GenServer

  #
  # Client API
  #

  def start_link do
    GenServer.start_link(__MODULE__, :ok)
  end

  def add_definition(reg_pid, local_type, def_record) do
    GenServer.cast(reg_pid, {:add_definition, local_type, def_record})
  end
  def add_datarecord(reg_pid, local_type, data) do
    GenServer.cast(reg_pid, {:add_datarecord, local_type, data})
  end

  def flush(reg_pid) do
    GenServer.call(reg_pid, :flush)
  end

  def get_definition(reg_pid, id) do
    GenServer.call(reg_pid, {:get_def, id})
  end

  def stop(reg_pid) do
    GenServer.stop(reg_pid)
  end

  #
  # Callbacks
  #

  # init

  def init(:ok) do
    {:ok, msg_pid} = Fit.Message.start_link
    {:ok, {%{}, %{}, msg_pid}}
  end

  # cast

  def handle_cast({:add_definition, local_type, def_record}, {def_records, data_records, msg_pid}) do
    case Map.has_key?(def_records, local_type) do
      true ->
        {_old_def, def_records} = Map.get_and_update(def_records, local_type, fn c -> {c, def_record} end)
        {data, data_records} = Map.pop(data_records, local_type)
        Fit.Message.process(msg_pid, data)
      false ->
        def_records = Map.put(def_records, local_type, def_record)
    end
    {:noreply, {def_records, data_records, msg_pid}}
  end

  def handle_cast({:add_datarecord, local_type, data}, {def_records, data_records, msg_pid}) do
    case Map.has_key?(data_records, local_type) do
      true ->
        data_records = Map.update(data_records, local_type, [data], fn d -> [data | d] end)
      false ->
        data_records = Map.put(data_records, local_type, [data])
    end
    {:noreply, {def_records, data_records, msg_pid}}
  end

  def handle_call(:flush, _from, {_def_records, data_records, msg_pid}) do
    Fit.Message.flush(msg_pid, Map.values(data_records))
    {:reply, msg_pid, nil}
  end

  # call

  def handle_call({:get_def, id}, _from, {def_records, data_records, msg_pid}) do
    {:reply, Map.fetch(def_records, id), {def_records, data_records, msg_pid}}
  end
end
