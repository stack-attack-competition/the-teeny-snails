defmodule Betonmylife.Application do
  use Application

  def start(_type, _args) do
    import Supervisor.Spec

    children = [
      # Start the endpoint when the application starts
      worker(Betonmylife.Store, []),
      supervisor(Betonmylife.Endpoint, []),
    ]
    Supervisor.start_link(children, opts())
  end

  defp opts do
    [
      strategy: :one_for_one,
      name: Betonmylife.Supervisor
    ]
  end
end
