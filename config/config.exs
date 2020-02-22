use Mix.Config

config :betonmylife, Betonmylife.Endpoint, port: String.to_integer(System.get_env("PORT") || "4000")