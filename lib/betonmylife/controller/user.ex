defmodule Betonmylife.User do
  use Plug.Router
  alias Betonmylife.UserRepository

  plug(:match)
  plug(:dispatch)

  @content_type "application/json"


  get "/" do
    case Repository.fetchAll(:user) do
      {:not_found} -> send_resp(conn, 200, Poison.encode!([]))
      {:found, user} -> send_resp(conn, 200, Poison.encode!(user))
    end
  end

  get "/:uuid" do
    uuid = Map.get(conn.params, "uuid")
    case Repository.fetchById(:user, uuid) do
      {:not_found} -> send_resp(conn, 404, "User not found!")
      {:found, user} -> send_resp(conn, 200, Poison.encode!(user))
    end

  end

  post "/" do
    user = User.from_dto(UserDto.from_map(conn.body_params))
    case Repository.add(:user, user) do
      {:created, user} -> send_resp(conn, 200, Poison.encode!(user))
      _ -> send_resp(conn, 500, 'Something went very wrong on our side!')
    end
  end

  delete "/:uuid" do
    uuid = Map.get(conn.params, "uuid")
    case Repository.delete(:user, uuid) do
      {:not_found} -> send_resp(conn, 404, "User not found")
      {:deleted, user} -> send_resp(conn, 200, Poison.encode!(user))
    end
  end

  match _ do
    send_resp(conn, 404, "Requested page not found!")
  end
end
