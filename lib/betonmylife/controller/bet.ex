defmodule Betonmylife.Bet do
  use Plug.Router
  alias Betonmylife.BetRepository
  alias Betonmylife.Store

  plug(:match)
  plug(:dispatch)

  @content_type "application/json"


  get "/" do
    send_resp(conn, 200, Poison.encode!(Repository.fetchAll(:bet)))
  end

  get "/:uuid" do
    uuid = Map.get(conn.params, "uuid")
    send_resp(conn, 200, Poison.encode!(BetRepository.fetchById(uuid)))
  end

  post "/" do
    bet = Bet.from_dto(BetDto.from_map(conn.body_params))
    Repository.add(:bet, bet)
    send_resp(conn, 200, Poison.encode!(bet))
  end

  patch "/:uuid" do
    uuid = Map.get(conn.params, "uuid")
    data = BetDto.from_map(conn.body_params)
    case BetRepository.update(uuid, data) do
      {:ok, result} -> send_resp(conn, 200, Poison.encode!(result))
      {:error} -> send_resp(conn, 400, "error")
    end
  end

  delete "/:uuid" do
    uuid = Map.get(conn.params, "uuid")
    Repository.delete(:bet, uuid)
    send_resp(conn, 200, "Succes")
  end

  match _ do
    send_resp(conn, 404, "Requested page not found!")
  end
end
