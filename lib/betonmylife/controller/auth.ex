defmodule Betonmylife.Auth do
  use Plug.Router

  plug(:match)
  plug(:dispatch)

  @content_type "application/json"

  post "/login" do
    send_resp(conn, 200, "Success!")
  end

  post "/register" do
    u = UserDto.from_map(conn.body_params)
    IO.inspect u.email
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
