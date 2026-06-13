import Config

config :loja, LojaWeb.Endpoint, cache_static_manifest: "priv/static/cache_manifest.json"

config :loja, Loja.Repo,
  username: "postgres",
  password: "postgres",
  hostname: "localhost",
  database: "loja_test",
  pool: Ecto.Adapters.SQL.Sandbox,
  pool_size: System.schedulers_online() * 2

config :logger, level: :warning
