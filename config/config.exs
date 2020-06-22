use Mix.Config

config :goth,
  json: "priv/creds.json" |> File.read!()
