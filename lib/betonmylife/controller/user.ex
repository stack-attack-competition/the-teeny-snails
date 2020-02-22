defmodule Betonmylife.User do
  use Plug.Router
  alias Betonmylife.UserRepository

  plug(:match)
  plug(:dispatch)

  @content_type "application/json"


  get "/" do
    send_resp(conn, 200, Poison.encode!(UserRepository.fetchAll()))
  end

  get "/:uuid" do
    uuid = Map.get(conn.params, "uuid")
    IO.inspect uuid
    IO.inspect UserRepository.fetchById(uuid)
    send_resp(conn, 200, Poison.encode!(UserRepository.fetchById(uuid)))
  end

  post "/" do
    user = User.from_dto(UserDto.from_map(conn.body_params))
    UserRepository.add(user)
    send_resp(conn, 200, Poison.encode!(user))
  end

  delete "/:uuid" do
    uuid = Map.get(conn.params, "uuid")
    IO.inspect uuid
    IO.inspect UserRepository.fetchById(uuid)
    UserRepository.deleteById(uuid)
    send_resp(conn, 200, "Succes")
  end

#  post "/" do
#    u = UserDto.from_map(conn.body_params)
#    IO.inspect u.email
#    send_resp(conn, 200, "Success!")
#  end

  match _ do
    send_resp(conn, 404, "Requested page not found!")
  end
end
