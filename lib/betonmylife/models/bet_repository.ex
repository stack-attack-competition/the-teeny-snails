defmodule Betonmylife.BetRepository do
  def add(bet) do
    Repository.add(:bet, bet)
  end

  def fetchById(uuid) do
    case Store.get(:bet) do
      {:found, bet} -> Map.get(bet, uuid)
      _ -> nil
    end
  end

  def fetchAll() do
    Repository.fetchAll(:bet)
  end

  def delete(key) do
    Repository.delete(:bet, key)
  end
end