defmodule Betonmylife.BetRepository do
  alias Betonmylife.Store

  def update(uuid, data) do
    case Store.get(:bet) do
      {:found, bets} ->
        bet = Map.get(bets, uuid)
        result = Bet.update(bet, data)
        newBets = Map.replace!(bets, uuid, result)
        Store.set(:bet, newBets)
        {:ok, result}
      _ -> {:error}
    end
  end

  def fetchById(uuid) do
    case Store.get(:bet) do
      {:found, bet} -> Map.get(bet, uuid)
      _ -> nil
    end
  end
end