defmodule Betonmylife.Utils do
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
end