defmodule LojaWeb.CartLive.Index do
  use LojaWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, items: [], total: Decimal.new("0.00"))}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <div class="mx-auto max-w-4xl px-4 py-8">
      <h1 class="mb-6 text-3xl font-bold text-gray-800">Carrinho</h1>

      <div class="text-center text-gray-500">
        <p class="mb-4 text-lg">Seu carrinho está vazio.</p>
        <a
          href="/catalogo"
          class="inline-block rounded-lg bg-blue-600 px-6 py-3 font-semibold text-white hover:bg-blue-700"
        >
          Ver Catálogo
        </a>
      </div>
    </div>
    """
  end
end
