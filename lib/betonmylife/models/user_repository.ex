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
end