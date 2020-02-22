defmodule Betonmylife.Bet do
  use Plug.Router
  alias Betonmylife.BetRepository
  alias Betonmylife.Store

  plug(:match)
  plug(:dispatch)

  @content_type "application/json"


  get "/" do
    case Repository.fetchAll(:bet) do
      {:not_found} -> send_resp(conn, 200, Poison.encode!([]))
      {:found, bet} -> send_resp(conn, 200, Poison.encode!(bet))
    end
  end

  get "/:uuid" do
    uuid = Map.get(conn.params, "uuid")
    case Repository.fetchById(:bet, uuid) do
      {:not_found} -> send_resp(conn, 404, "Bet not found!")
      {:found, bet} -> send_resp(conn, 200, Poison.encode!(bet))
    end
  end

  post "/" do
    bet = Bet.from_dto(BetDto.from_map(conn.body_params))
    case Repository.add(:bet, bet) do
      {:created, bet} -> send_resp(conn, 200, Poison.encode!(bet))
      _ -> send_resp(conn, 500, 'Something went very wrong on our side!')
    end
  end

  patch "/:uuid" do
    uuid = Map.get(conn.params, "uuid")
    data = BetDto.from_map(conn.body_params)
    case BetRepository.update(uuid, data) do
      {:ok, result} -> send_resp(conn, 200, Poison.encode!(result))
      {:error} -> send_resp(conn, 400, "Invalid bet update")
    end
  end

  delete "/:uuid" do
    uuid = Map.get(conn.params, "uuid")
    case Repository.delete(:bet, uuid) do
      {:not_found} -> send_resp(conn, 404, "Bet not found")
      {:deleted, bet} -> send_resp(conn, 200, Poison.encode!(bet))
    end
  end

  match _ do
    send_resp(conn, 404, "Requested page not found!")
  end
end
