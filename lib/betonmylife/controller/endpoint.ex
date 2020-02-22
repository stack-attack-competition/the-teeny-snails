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
    with {:ok, [port: port] = config} <- Application.fetch_env(:betonmylife, __MODULE__) do
      Logger.info("Starting server at http://localhost:#{port}/")
      Plug.Adapters.Cowboy.http(__MODULE__, [], config)
    end
  end
  
  forward("/hello", to: Betonmylife.Router)
  forward("/auth", to: Betonmylife.Auth)
  forward("/users", to: Betonmylife.User)


  match _ do
    send_resp(conn, 404, "Requested page not found!")
  end

end