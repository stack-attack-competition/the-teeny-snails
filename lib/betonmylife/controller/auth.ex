defmodule Betonmylife.Auth do
  use Plug.Router
  alias Betonmylife.UserStore

  plug(:match)
  plug(:dispatch)

  @content_type "application/json"

  post "/login" do
    ld = LoginDto.from_map(conn.body_params)
    user = UserStore.fetch(ld.email, ld.password)
    send_resp(conn, 200, Poison.encode!(user))
  end

  post "/register" do
    UserStore.add(UserDto.from_map(conn.body_params))
    send_resp(conn, 200, "Success!")
  end

  match _ do
    send_resp(conn, 404, "Requested page not found!")
  end
end
