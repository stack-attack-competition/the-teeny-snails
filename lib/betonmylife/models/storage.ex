defmodule Betonmylife.UserStore do
  alias Betonmylife.Store

  def fetch(email, password) do
    users = Store.fetch(:user)
    Enum.map(users, fn user -> IO.inspect user end)
  end

  def add(u) do
    user = User.from_dto(u)
    case Store.get(:user) do
      {:not_found} -> not_found_add(user)
      {:found, result} -> found_add(result, user)
    end

    userStore = Store.fetch(:user)
  end

  def not_found_add(user) do
    Store.set(:user, %{user.id => user})
  end

  def found_add(result, user) do
    result = Map.put_new(result, user.id, user)
    Store.set(:user,  result)
  end
end