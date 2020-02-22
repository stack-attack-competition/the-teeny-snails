defmodule Betonmylife.User do
  use Plug.Router
  alias Betonmylife.UserStore

  plug(:match)
  plug(:dispatch)

  @content_type "application/json"


  get "/" do
    send_resp(conn, 200, Poison.encode!(UserStore.fetchAll()))
  end

  get "/:uuid" do
    uuid = Map.get(conn.params, "uuid")
    IO.inspect uuid
    IO.inspect UserStore.fetchById(uuid)
    send_resp(conn, 200, Poison.encode!(UserStore.fetchById(uuid)))
  end

  post "/" do
    user = User.from_dto(UserDto.from_map(conn.body_params))
    UserStore.add(user)
    send_resp(conn, 200, Poison.encode!(user))
  end

  delete "/:uuid" do
    uuid = Map.get(conn.params, "uuid")
    IO.inspect uuid
    IO.inspect UserStore.fetchById(uuid)
    UserStore.deleteById(uuid)
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
