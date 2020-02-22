defmodule Betonmylife.UserStore do
  alias Betonmylife.Store

  def fetch(email, password) do
    users = Store.fetch(:user)
    result = Enum.map(users, fn {k, v} ->
      if v.email == email do
        v.id
      end
    end)
    users[List.first(result)]
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