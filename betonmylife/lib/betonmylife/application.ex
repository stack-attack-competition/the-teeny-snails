defmodule Betonmylife.Application do
  use Superviser.spec
  use Application

  def start(_type, _args),
      do: Supervisor.start_link(children(), opts())

  defp children do
    [
      supervisor(Betonmylife.Endpoint),
      worker(Betonmylife.Store),
    ]
  end

  defp opts do
    [
      strategy: :one_for_one,
      name: Betonmylife.Supervisor
    ]
  end
end
