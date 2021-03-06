defmodule Firestore.MixProject do
  use Mix.Project

  def project do
    [
      app: :firestore,
      version: "0.1.0",
      elixir: "~> 1.10",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:goth, "~> 1.2.0"},
      {:protobuf, "~> 0.7.1"},
      {:google_protos, "~> 0.1"},
      {:grpc, github: "elixir-grpc/grpc"},
      {:elixir_uuid, "~> 1.2"}
    ]
  end
end
