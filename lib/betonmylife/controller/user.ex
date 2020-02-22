defmodule Betonmylife.User do
  use Plug.Router


  plug(:match)
  plug(:dispatch)

  @content_type "application/json"

  get "/" do
    IO.puts(
      UserDto.from_map(
        '{
  "isDeleted": false,
  "email": "oridun@huk.ki",
  "password": "3HR!$&Siuo",
  "firstName": "Myrtle",
  "lastName": "Gray",
  "pictureUrl": "http://www.gravatar.com/avatar/f24faa2f11a7d48e9c70b9d4a242f51a"
}'
      )
    )
    #    Store.set('users', UserDto.from_map('{
    #  "id": "2c12d538-8e7d-520a-987e-b096213ae83e",
    #  "isDeleted": false,
    #  "email": "oridun@huk.ki",
    #  "password": "3HR!$&Siuo",
    #  "firstName": "Myrtle",
    #  "lastName": "Gray",
    #  "pictureUrl": "http://www.gravatar.com/avatar/f24faa2f11a7d48e9c70b9d4a242f51a"
    #}'))
    #    IO.puts(Store.fetch('users'))
    send_resp(conn, 200, "Success!")
  end

  post "/" do
    u = UserDto.from_map(conn.body_params)
    IO.inspect u.email
    send_resp(conn, 200, "Success!")
  end

  match _ do
    send_resp(conn, 404, "Requested page not found!")
  end
end
