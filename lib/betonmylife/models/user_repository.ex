defmodule Betonmylife.UserRepository do
  alias Betonmylife.Store

  def login(email, password) do
    users = Store.fetch(:user)
    result = Enum.map(
      users,
      fn {k, v} ->
        if v.email == email and v.password == password do
          v.id
        end
      end
    )
    users[List.first(result)]
  end

  def update(uuid, data) do
    case Store.get(:user) do
      {:found, users} ->
        user = Map.get(users, uuid)
        result = Bet.update(user, data)
        newUsers = Map.replace!(users, uuid, result)
        Store.set(:user, newUsers)
        {:ok, result}
      _ -> {:error}
    end
  end
end