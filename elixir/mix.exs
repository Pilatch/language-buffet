defmodule ElixirFoo.MixProject do
  use Mix.Project

  def project do
    [
      app: :elixirFoo,
      version: "0.1.0",
      elixir: "~> 1.6-dev",
      elixirc_paths: ["lib"],
      start_permanent: Mix.env == :prod,
      deps: deps()
    ]
  end

  def deps do
    [
      {:ex_json_schema, "~> 0.5.4"},
      {:poison, "~> 3.1"}
    ]
  end
end
