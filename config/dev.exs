import Config

config :loja, LojaWeb.Endpoint,
  http: [ip: {0, 0, 0, 0}, port: 4000],
  code_reloader: true,
  check_origin: false,
  watchers: [
    esbuild: {Esbuild, :install_and_run, [:loja, ~w(--sourcemap=inline --watch)]},
    tailwind: {Tailwind, :install_and_run, [:loja, ~w(--watch)]}
  ]

config :loja, Loja.Repo,
  username: "aquental",
  password: "aquental",
  hostname: "hermes",
  database: "loja_dev",
  ssl: [verify: :verify_none]

config :logger, :console, format: "[$level] $message\n"

config :phoenix, :stacktrace_depth, 20
config :phoenix, :plug_init_mode, :runtime
