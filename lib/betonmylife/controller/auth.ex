defmodule Betonmylife.Auth do
  use Plug.Router
  alias Betonmylife.UserRepository
  alias Betonmylife.Utils

  plug(:match)
  plug(:dispatch)

  @content_type "application/json"

  post "/login" do
    ld = LoginDto.from_map(conn.body_params)
    user = UserRepository.login(ld.email, ld.password)
    send_resp(conn, 200, Poison.encode!(user))
  end

  post "/register" do
    ud = UserDto.from_map(conn.body_params)
    cond do
      !Utils.email_validation(ud.email) -> send_resp(conn, 409, "Email already taken")
      true ->
        case UserDto.create_validate(ud) do
          {:error, result} -> send_resp(conn, 400, result)
          _ ->
            user = User.from_dto(ud)
            UserRepository.add(user)
            send_resp(conn, 200, Poison.encode!(user))
        end
    end
  end

  match _ do
    send_resp(conn, 404, "Requested page not found!")
  end
end
