defmodule Betonmylife.Bet do
  use Plug.Router
  alias Betonmylife.BetRepository
  alias Betonmylife.Store

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

  patch "/:uuid" do
    uuid = Map.get(conn.params, "uuid")
    betDto = BetDto.from_map(conn.body_params)
    case Store.get(:bet) do
      {:found, bets} ->
        bet = Map.get(bets, uuid)
        new = Bet.update(bet, betDto)
#        IO.inspect new
        newBets = Map.replace!(bets, uuid, new)
        Store.set(:bet, newBets)
        send_resp(conn, 200, Poison.encode!(new))
      _ -> send_resp(conn, 400, "dunno")
    end
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
