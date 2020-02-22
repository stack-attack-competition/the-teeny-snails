defmodule Betonmylife.Store do
  use GenServer
  require Logger

#  link the store into the children pool
  def start_link(opts \\ []) do
    Logger.debug("starting #{inspect __MODULE__}")
    GenServer.start_link(__MODULE__, [
      {:ets_table_name, :store_table},
      {:log_limit, 1_000_000}
    ], [name: __MODULE__])
  end

#  initialize the back storage
  def init(args) do
    [{:ets_table_name, ets_table_name}, {:log_limit, log_limit}] = args
    :ets.new(ets_table_name, [:named_table, :set, :private])
    {:ok, %{log_limit: log_limit, ets_table_name: ets_table_name, timer_refs: %{}}}
  end

#  fetch translate the get function's tuple to real value
  def fetch(key) do
    case get(key) do
      {:not_found} -> nil
      {:found, result} -> result
    end
  end

#  get returns a tuple whether found any data
  def get(key) do
    case GenServer.call(__MODULE__, {:get, key}) do
      [] -> {:not_found}
      [{_key, result}] -> {:found, result}
    end
  end

#  set an arbitrary value for the certain key
  def set(key, value) do
    GenServer.call(__MODULE__, {:set, key, value})
  end

#  set an arbitrary value for the certain key with expiration
  def set(key, value, exp) do
    GenServer.call(__MODULE__, {:set, key, value, exp})
  end

#  delete the key's value and unset the key
  def delete(key) do
    GenServer.call(__MODULE__, {:delete, key})
  end

#  returns all of the saved key
  def keys() do
    GenServer.call(__MODULE__, {:get_all_keys})
  end

#  totally wipe the background storage
  def clear() do
    GenServer.call(__MODULE__, {:clear})
  end

#  get the time-to-live value of the key
  def get_ttl(key) do
    GenServer.call(__MODULE, {:get_ttl, key})
  end

# background handlers of the GenServer

  def handle_call({:get, key}, _from, state) do
    %{ets_table_name: ets_table_name} = state
    result = :ets.lookup(ets_table_name, key)
    {:reply, result, state}
  end

  def handle_call({:delete, key}, _from, state) do
    %{ets_table_name: ets_table_name} = state
    result = :ets.delete(ets_table_name, key)
    {:reply, result, state}
  end

  def handle_call({:set, key, value}, _from, state) do
    %{ets_table_name: ets_table_name} = state
    cancel_timer(key, state)
    true = :ets.insert(ets_table_name, {key, value})
    {:reply, result, state}
  end

  def handle_call({:set, key, value}, _from, state) do
    %{ets_table_name: ets_table_name} = state
    cancel_timer(key, state)
    timer_ref = Process.send_after(__MODULE__, {:delete, key}, expiration)
    new_timer_refs = state
    |> Map.get(:timer_refs)
    |> Map.put(key, timer_ref)
    state = state |> Map.put(:timer_refs, new_timer_refs)
    true = :ets.insert(ets_table_name, {key, value})
    {:reply, result, state}
  end

  def handle_call({:get_all_keys}, _from, state) do
    %{ets_table_name: ets_table_name} = state
    result = :ets.foldl(fn({key, val}, acc) ->
      [key] ++ acc end, [], ets_table_name)
    {:reply, result, state}
  end

  def handle_call({:clear}, _from, state) do
    %{ets_table_name: ets_table_name} = state
    result = :ets.delete_all_objects(ets_table_name)
    {:reply, result, state}
  end

  def handle_call({:get_ttl, key}, _from, sate) do
    result = Process.read_timer(state.timer_refs[key])
    {:reply, result, state}
  end

  def handle_call({:delete, key}, _from, state) do
    %{ets_table_name: ets_table_name} = state
    result = :ets.delete(ets_table_name, key)
    {:reply, result, state}
  end

  defp cancel_timer(key, state) do
    case timer_ref = state.timer_refs[key] do
      nil -> nil
      _ -> Process.cancel_timer(timer_ref)
    end
  end
end