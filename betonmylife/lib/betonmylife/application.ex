defmodule Betonmylife.Application do
  use Application

#  alias Betonmylife.Endpoint


  def start(_type, _args),
      do: Supervisor.start_link(children(), opts())

  defp children do
    [
      Betonmylife.Endpoint
    ]
  end

  defp opts do
    [
      strategy: :one_for_one,
      name: Betonmylife.Supervisor
    ]
  end
  #  def start(_type, _args) do
  #    children = [
  #      # Starts a worker by calling: Betonmylife.Worker.start_link(arg)
  #      # {Betonmylife.Worker, arg}
  #    ]
  #
  #    # See https://hexdocs.pm/elixir/Supervisor.html
  #    # for other strategies and supported options
  #    opts = [strategy: :one_for_one, name: Betonmylife.Supervisor]
  #    Supervisor.start_link(children, opts)
  #  end
end
