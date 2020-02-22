defmodule Betonmylife.UserRepository do
  alias Betonmylife.Store

  def login(email, password) do
    users = Store.fetch(:user)
    result = Enum.map(users, fn {k, v} ->
      if v.email == email and v.password == password do
        v.id
      end
    end)
    users[List.first(result)]
  end

  def fetchAll() do
    Repository.fetchAll(:user)
  end

  def fetchById(uuid) do
    {:found, users } = Store.get(:user)
    Map.get(users, uuid)
  end

  def deleteById(uuid) do
    Store.delete(uuid);
  end

  def add(user) do
    Repository.add(:user, user)
  end
end