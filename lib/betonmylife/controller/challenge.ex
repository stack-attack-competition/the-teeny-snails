defmodule Betonmylife.Challenge do
  use Plug.Router
  alias Betonmylife.ChallengeRepository

  plug(:match)
  plug(:dispatch)

  @content_type "application/json"


  get "/" do
    send_resp(conn, 200, Poison.encode!(ChallengeRepository.fetchAll()))
  end

  get "/:uuid" do
    uuid = Map.get(conn.params, "uuid")
    send_resp(conn, 200, Poison.encode!(ChallengeRepository.fetchById(uuid)))
  end

  post "/" do
    challenge = Challenge.from_dto(ChallengeDto.from_map(conn.body_params))
    ChallengeRepository.add(challenge)
    send_resp(conn, 200, Poison.encode!(challenge))
  end

  delete "/:uuid" do
    uuid = Map.get(conn.params, "uuid")
    ChallengeRepository.delete(uuid)
    send_resp(conn, 200, "Succes")
  end

  match _ do
    send_resp(conn, 404, "Requested page not found!")
  end
end
