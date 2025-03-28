defmodule AdventOfCode.MixProject do
  use Mix.Project

  def project do
    [
      app: :advent_of_code,
      version: "0.1.0",
      elixir: "~> 1.15",
      start_permanent: Mix.env() == :prod,
      escript: [main_module: AdventOfCode],
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
      {:benchee, "~> 1.0", only: :dev},
      {:libgraph, "~> 0.16.0"},
      {:optimus, "~> 0.2"},
      {:typed_struct, "~> 0.3"},
      {:req, ">= 0.4.0"},
      {:nx, "~> 0.9"}
    ]
  end
end
