defmodule Fit.Message do
  use GenServer

  ## Client API

  def start_link do
    GenServer.start_link(__MODULE__, :ok, name: :messages)
  end

  def process(local_type, old_def, data) do
    GenServer.cast(:messages, {:process, local_type, old_def, data})
  end

  def get(local_type) do
    GenServer.call(:messages, {:get, local_type})
  end

  ## Callbacks

  def init(:ok) do
    {:ok, %{}}
  end

  def handle_cast({:process, local_type, old_def, data}, state) do
    new_state = Map.update(state, local_type, {old_def, data}, fn {key, val} -> {key, val ++ data} end)
    {:noreply, new_state}
  end

  def handle_call({:get, local_type}, _from, state) do
    case Map.fetch(state, local_type) do
      {:ok, result} -> {:reply, result, state}
      :error -> {:reply, :error, state}
    end
  end
end
