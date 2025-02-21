defmodule Publisher.MixProject do
  use Mix.Project

  def project do
    [
      package: package(),
      app: :publisher,
      description: "An Easy Markdown to Static HTML generator",
      version: "0.1.0",
      elixir: "~> 1.17",
      start_permanent: Mix.env() == :prod,
      escript: [main_module: Publisher, name: "emporium", include_priv_for: [Publisher]],
      deps: deps(),
      source: "https://github.com/jowi-dev/publisher"
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
      {:makeup_erlang, ">= 0.0.0"},
      {:ex_doc, "~> 0.36.1"}
    ]
  end

  defp package do
    [
      files: ~w(lib priv .formatter.exs mix.exs README* LICENSE*),
      licenses: ["Apache-2.0"],
      links: %{"GitHub" => "https://github.com/jowi-dev/publisher"}
    ]
  end
end
