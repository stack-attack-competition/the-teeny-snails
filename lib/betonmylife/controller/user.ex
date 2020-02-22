defmodule Betonmylife.User do
  use Plug.Router
  alias Betonmylife.UserStore

  plug(:match)
  plug(:dispatch)

  @content_type "application/json"

  post "/" do

    newUser = UserDto.from_map(conn.body_params)
    UserStore.add(newUser)
    send_resp(conn, 200, Poison.encode!(newUser))
  end

  post "/" do
    u = UserDto.from_map(conn.body_params)
    IO.inspect u.email
    send_resp(conn, 200, "Success!")
  end

  match _ do
    send_resp(conn, 404, "Requested page not found!")
  end
end
