import Config

config :loja,
  ecto_repos: [Loja.Repo],
  ash_domains: [Loja.Catalog, Loja.Sales, Loja.Consultant]

config :loja, LojaWeb.Endpoint,
  url: [host: "localhost"],
  render_errors: [formats: [html: LojaWeb.ErrorHTML, json: LojaWeb.ErrorJSON]],
  pubsub_server: Loja.PubSub,
  live_view: [signing_salt: "CHANGE_ME"]

config :loja, LojaWeb.Gettext, locales: ~w(en pt_BR), default_locale: "pt_BR"

config :ash, :utc_datetime_usec, type: Ash.Type.UTCDatetimeUsec, default: &DateTime.utc_now/0

config :loja, Loja.Repo,
  username: "postgres",
  password: "postgres",
  hostname: "localhost",
  database: "loja_dev",
  ssl: false,
  ssl_opts: [verify: :verify_none],
  stacktrace: true,
  show_sensitive_data_on_connection_error: true,
  pool_size: 10

config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :phoenix, :json_library, Jason

import_config "#{config_env()}.exs"
