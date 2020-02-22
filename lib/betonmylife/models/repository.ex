defmodule Repository do
  alias Betonmylife.Store

  def fetchAll(type) do
    Store.get(type)
  end

  def fetchById(type, uuid) do
    case Store.get(type) do
      {:not_found} -> {:not_found}
      {:found, dataSet} ->
        case Map.get(dataSet, uuid) do
          nil -> {:not_found}
          result -> {:found, result}
        end
    end
  end

  def filterBy(type, key, val) do
    dataSet = Store.fetch(type)
    Enum.filter(dataSet, fn d -> Map.get(d, key) == val end)
  end


  def update(type, uuid, resource) do
    dataSet = Store.fetch(type)
    current = Map.get(dataSet, uuid)
  end

  def delete(type, key) do
    case Store.get(type) do
      {:not_found} -> {:not_found}
      {:found, dataSet} ->
        deletedUser = Map.get(dataSet, key)
        dataSet = Map.delete(dataSet, key)
        Store.set(type, dataSet)
        {:deleted, deletedUser}
    end

  end

  def add(type, resource) do
    case Store.get(type) do
      {:not_found} -> not_found_add(type, resource)
      {:found, result} -> found_add(type, result, resource)
    end
  end

  def not_found_add(type, resource) do
    dataSet = %{resource.id => resource}
    Store.set(type, dataSet)
    {:created, resource}
  end

  def found_add(type, result, resource) do
    result = Map.put_new(result, resource.id, resource)
    Store.set(type, result)
    {:created, resource}
  end
end