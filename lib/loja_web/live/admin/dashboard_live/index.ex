defmodule LojaWeb.Admin.DashboardLive.Index do
  use LojaWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, stats: %{orders_today: 0, revenue_month: Decimal.new("0"), low_stock: 0})}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <div class="p-6">
      <h1 class="mb-6 text-2xl font-bold text-gray-800">Dashboard</h1>

      <div class="grid gap-4 md:grid-cols-3">
        <div class="rounded-xl bg-white p-6 shadow">
          <p class="text-sm text-gray-500">Pedidos Hoje</p>
          <p class="text-3xl font-bold"><%= @stats.orders_today %></p>
        </div>
        <div class="rounded-xl bg-white p-6 shadow">
          <p class="text-sm text-gray-500">Receita do Mês</p>
          <p class="text-3xl font-bold">R$ 0,00</p>
        </div>
        <div class="rounded-xl bg-white p-6 shadow">
          <p class="text-sm text-gray-500">Estoque Baixo</p>
          <p class="text-3xl font-bold"><%= @stats.low_stock %></p>
        </div>
      </div>

      <div class="mt-8 rounded-xl bg-white p-6 shadow">
        <h2 class="mb-4 text-lg font-semibold">Pedidos Recentes</h2>
        <p class="text-gray-500">Nenhum pedido ainda.</p>
      </div>
    </div>
    """
  end
end
