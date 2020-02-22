defmodule Betonmylife.Router do
  use Plug.Router

  plug(:match)
  plug(:dispatch)

  @content_type "application/json"

  get "/" do
    conn
    |> put_resp_content_type(@content_type)
    |> send_resp(200, message())
  end

  post "/asd" do
    bet = BetDto.from_map(conn.body_params)
    IO.inspect conn.body_params
    IO.inspect bet
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
