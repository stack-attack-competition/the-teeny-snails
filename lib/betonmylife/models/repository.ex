defmodule Repository do
  alias Betonmylife.Store

  def fetchAll(type) do
    Store.fetch(type)
  end

  def delete(type, key) do
    dataSet = Store.fetch(type)
    Map.delete(dataSet, key)
    Store.set(type, dataSet)
  end

  def add(type, resource) do
    case Store.get(type) do
      {:not_found} -> not_found_add(type, resource)
      {:found, result} -> found_add(type, result, resource)
    end
  end

  def not_found_add(type, resource) do
    Store.set(type, %{resource.id => resource})
  end

  def found_add(type, result, resource) do
    result = Map.put_new(result, resource.id, resource)
    Store.set(type,  result)
  end
end