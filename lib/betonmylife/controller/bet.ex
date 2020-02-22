defmodule Betonmylife.Bet do
  use Plug.Router
  alias Betonmylife.BetRepository

  plug(:match)
  plug(:dispatch)

  @content_type "application/json"


  get "/" do
    send_resp(conn, 200, Poison.encode!(BetRepository.fetchAll()))
  end

  get "/:uuid" do
    uuid = Map.get(conn.params, "uuid")
    send_resp(conn, 200, Poison.encode!(BetRepository.fetchById(uuid)))
  end

  post "/" do
    bet = Bet.from_dto(BetDto.from_map(conn.body_params))
    BetRepository.add(bet)
    send_resp(conn, 200, Poison.encode!(bet))
  end

  delete "/:uuid" do
    uuid = Map.get(conn.params, "uuid")
    BetRepository.delete(uuid)
    send_resp(conn, 200, "Succes")
  end

  match _ do
    send_resp(conn, 404, "Requested page not found!")
  end
end
