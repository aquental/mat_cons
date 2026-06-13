import Config

if config_env() == :prod do
  config :loja, LojaWeb.Endpoint, server: true

  config :loja, Loja.Repo,
    url: System.get_env("DATABASE_URL"),
    pool_size: String.to_integer(System.get_env("POOL_SIZE", "10")),
    ssl: true
end

config :loja, :ash_domains, [Loja.Catalog, Loja.Sales, Loja.Consultant]
