defmodule Betonmylife.UserStore do
  alias Betonmylife.Store

  def email_validation(email) do
    users = Store.fetch(:user)
    cond do
      users != nil ->
        result = Enum.map(users, fn {k, v} ->
          cond do
            v.email == email -> v.id
            true -> nil
          end
        end)
        result == [nil]
      true -> true
    end
  end

  def fetch(email, password) do
    users = Store.fetch(:user)
    result = Enum.map(users, fn {k, v} ->
      if v.email == email do
        v.id
      end
    end)
    users[List.first(result)]
  end

  def fetchAll() do
    Store.fetch(:user)
  end

  def fetchById(uuid) do
    {:found, users } = Store.get(:user)
    Map.get(users, uuid)
  end

  def deleteById(uuid) do
    Store.delete(uuid);
  end

  def add(user) do
    case Store.get(:user) do
      {:not_found} -> not_found_add(user)
      {:found, result} -> found_add(result, user)
    end
  end

  def not_found_add(user) do
    Store.set(:user, %{user.id => user})
  end

  def found_add(result, user) do
    result = Map.put_new(result, user.id, user)
    Store.set(:user,  result)
  end
end