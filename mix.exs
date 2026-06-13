defmodule Loja.MixProject do
  use Mix.Project

  def project do
    [
      app: :loja,
      version: "0.1.0",
      elixir: "~> 1.18",
      elixirc_paths: elixirc_paths(Mix.env()),
      start_permanent: Mix.env() == :prod,
      aliases: aliases(),
      deps: deps()
    ]
  end

  def application do
    [
      mod: {Loja.Application, []},
      extra_applications: [:logger, :runtime_tools]
    ]
  end

  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  defp deps do
    [
      # Phoenix
      {:phoenix, "~> 1.7"},
      {:phoenix_live_view, "~> 1.0"},
      {:phoenix_html, "~> 4.1"},
      {:phoenix_live_reload, "~> 1.5", only: :dev},
      {:phoenix_live_dashboard, "~> 0.8"},
      {:floki, ">= 0.30.0", only: :test},

      # Ash Framework Core
      {:ash, "~> 3.0"},
      {:ash_phoenix, "~> 2.0"},
      {:ash_postgres, "~> 2.0"},
      {:ash_graphql, "~> 1.0"},
      {:ash_admin, "~> 0.11"},

      # Web Assets
      {:tailwind, "~> 0.2", runtime: Mix.env() == :dev},
      {:esbuild, "~> 0.8", runtime: Mix.env() == :dev},

      # Database
      {:postgrex, ">= 0.0.0"},

      # HTTP / API
      {:req, "~> 0.5"},
      {:jason, "~> 1.4"},

      # Utility
      {:gettext, "~> 0.26"},
      {:telemetry_metrics, "~> 1.0"},
      {:telemetry_poller, "~> 1.1"},
      {:dns_cluster, "~> 0.1.1"},
      {:finch, "~> 0.13"},

      # Dev / Test
      {:styler, "~> 1.0", only: [:dev, :test], runtime: false},
      {:credo, "~> 1.7", only: [:dev, :test], runtime: false}
    ]
  end

  defp aliases do
    [
      setup: ["deps.get", "ecto.setup", "assets.setup", "assets.build"],
      "ecto.setup": ["ecto.create", "ecto.migrate", "run priv/repo/seeds.exs"],
      "ecto.reset": ["ecto.drop", "ecto.setup"],
      test: ["ecto.create --quiet", "ecto.migrate --quiet", "test"],
      "assets.setup": ["tailwind.install --if-missing", "esbuild.install --if-missing"],
      "assets.build": ["tailwind loja", "esbuild loja"],
      "assets.deploy": ["tailwind loja --minify", "esbuild loja --minify", "phx.digest"],
      "ash.setup": ["ash.gen.setup"]
    ]
  end
end
