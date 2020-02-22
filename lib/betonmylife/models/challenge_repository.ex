defmodule Betonmylife.ChallengeRepository do
  def update(uuid, data) do
    case Store.get(:challenge) do
      {:found, challenges} ->
        challenge = Map.get(bets, uuid)
        result = Challenge.update(bet, data)
        newChallenges = Map.replace!(challenges, uuid, result)
        Store.set(:bet, newChallenges)
        {:ok, result}
      _ -> {:error}
    end
  end
end