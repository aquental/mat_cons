defmodule Loja.Application do
  @moduledoc false
  use Application

  @impl true
  def start(_type, _args) do
    children = [
      LojaWeb.Telemetry,
      Loja.Repo,
      {DNSCluster, query: Application.get_env(:loja, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: Loja.PubSub},
      {Finch, name: Loja.Finch},
      LojaWeb.Endpoint
    ]

    opts = [strategy: :one_for_one, name: Loja.Supervisor]
    Supervisor.start_link(children, opts)
  end

  @impl true
  def config_change(changed, _new, removed) do
    LojaWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
