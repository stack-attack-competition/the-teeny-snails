defmodule Betonmylife.Endpoint do
  use Plug.Router

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
    Plug.Adapters.Cowboy.http(__MODULE__, [])
  end

  #  def child_spec(opts) do
  #    %{
  #      id: __MODULE__,
  #      start: {__MODULE__, :start_link, [opts]}
  #    }
  #  end
  #
  #  def start_link(_opts) do
  #    with {:ok, [port: port] = config} <- config() do
  #      Logger.info("Starting server at http://localhost:#{port}/")
  #      Cowboy2.http(__MODULE__, [], config)
  #    end
  #  end
  #
  forward("/hello", to: Betonmylife.Router)


  match _ do
    send_resp(conn, 404, "Requested page not found!")
  end

end