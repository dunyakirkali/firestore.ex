use Mix.Config

config :logger, level: :error
config :grpc, start_server: true
config :goth,
  json: "priv/creds.json" |> File.read!()
