defmodule Betonmylife.Auth do
  use Plug.Router
  alias Betonmylife.UserStore

  plug(:match)
  plug(:dispatch)

  @content_type "application/json"

  post "/login" do
    LoginDto.from_map(conn.body_params)
    send_resp(conn, 200, "Success!")
  end

  post "/register" do
    UserStore.add(UserDto.from_map(conn.body_params))
    send_resp(conn, 200, "Success!")
  end

  match _ do
    send_resp(conn, 404, "Requested page not found!")
  end

  defp message do
    Poison.encode!(
      %{
        response_type: "in_channel",
        text: "I'm alive!"
      }
    )
  end
end
