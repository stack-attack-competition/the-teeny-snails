defmodule Betonmylife.Endpoint do
  use Plug.Router

  require Logger

  plug(:match)

  plug(
    Plug.Parsers,
    parsers: [:json],
    pass: ["application/json"],
    json_decoder: Poison
  )

  plug(:dispatch)

  def child_spec(opts) do
    %{
      id: __MODULE__,
      start: {__MODULE__, :start_link, [opts]}
    }
  end

  def start_link(_opts \\ []) do
    Logger.info("Starting server at http://localhost:4000/")
    Plug.Adapters.Cowboy.http(__MODULE__, [])
  end

  forward("/hello", to: Betonmylife.Router)
  forward("/auth", to: Betonmylife.Auth)


  match _ do
    send_resp(conn, 404, "Requested page not found!")
  end

end