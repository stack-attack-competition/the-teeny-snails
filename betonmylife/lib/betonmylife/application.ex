defmodule Betonmylife.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    import Supervisor.Spec
#    Storage.new()


    children = [
      worker(Betonmylife.Store, []),
      # Starts a worker by calling: Betonmylife.Worker.start_link(arg)
      # {Betonmylife.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Betonmylife.Supervisor]
    Supervisor.start_link(children, opts)
  end
end

defmodule Storage do
  use KVX.Bucket
end
