defmodule Betonmylife.Challenge do
  use Plug.Router
  alias Betonmylife.ChallengeRepository

  plug(:match)
  plug(:dispatch)

  @content_type "application/json"


  get "/" do
    case Repository.fetchAll(:challenege) do
      {:not_found} -> send_resp(conn, 200, Poison.encode!([]))
      {:found, challenge} -> send_resp(conn, 200, Poison.encode!(challenge))
    end
  end

  get "/:uuid" do
    uuid = Map.get(conn.params, "uuid")
    case Repository.fetchById(:challenege, uuid) do
      {:not_found} -> send_resp(conn, 404, "Challenge not found!")
      {:found, challenge} -> send_resp(conn, 200, Poison.encode!(challenge))
    end
  end

#  get "/:uuid" do
#    uuid = Map.get(conn.params, "uuid")
#    send_resp(conn, 200, Poison.encode!(ChallengeRepository.fetchById(uuid)))
#  end

  post "/" do
    user = User.from_dto(UserDto.from_map(conn.body_params))
    case Repository.add(:challenege, user) do
      {:created, challenge} -> send_resp(conn, 200, Poison.encode!(challenge))
      _ -> send_resp(conn, 500, 'Something went very wrong on our side!')
    end
  end

#  post "/" do
#    challenge = Challenge.from_dto(ChallengeDto.from_map(conn.body_params))
#    ChallengeRepository.add(challenge)
#    send_resp(conn, 200, Poison.encode!(challenge))
#  end

  delete "/:uuid" do
    uuid = Map.get(conn.params, "uuid")
    case Repository.delete(:challenege, uuid) do
      {:not_found} -> send_resp(conn, 404, "Challenge not found")
      {:deleted, challenge} -> send_resp(conn, 200, Poison.encode!(challenge))
    end
  end

#  delete "/:uuid" do
#    uuid = Map.get(conn.params, "uuid")
#    ChallengeRepository.delete(uuid)
#    send_resp(conn, 200, "Succes")
#  end

  match _ do
    send_resp(conn, 404, "Requested page not found!")
  end
end
