defmodule Publisher.MixProject do
  use Mix.Project

  def project do
    [
      app: :publisher,
      version: "0.1.0",
      elixir: "~> 1.17",
      start_permanent: Mix.env() == :prod,
      escript: [main_module: Publisher, name: "emporium", include_priv_for: [Publisher]],
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
      {:nimble_publisher, "~> 1.0"},
      {:makeup_elixir, ">= 0.0.0"},
      {:makeup_erlang, ">= 0.0.0"}
    ]
  end
end
