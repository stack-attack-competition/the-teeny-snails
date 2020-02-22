defmodule Betonmylife.ChallengeRepository do
  def add(challenege) do
    Repository.add(:challenege, challenege)
  end

  def fetchById(uuid) do
    case Store.get(:challenege) do
      {:found, challenege} -> Map.get(challenege, uuid)
      _ -> nil
    end
  end

  def fetchAll() do
    Repository.fetchAll(:challenege)
  end

  def delete(key) do
    Repository.delete(:challenege, key)
  end
end