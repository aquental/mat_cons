defmodule LojaWeb.CatalogLive.Index do
  use LojaWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, products: [], search: "", loading: true)}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <div class="mx-auto max-w-7xl px-4 py-8">
      <h1 class="mb-6 text-3xl font-bold text-gray-800">Catálogo de Produtos</h1>

      <!-- Busca -->
      <div class="mb-8">
        <input
          type="text"
          placeholder="Buscar produtos..."
          class="w-full rounded-lg border border-gray-300 p-3"
        />
      </div>

      <!-- Grid placeholder -->
      <div class="text-center text-gray-500">
        <p class="text-lg">Catálogo em construção.</p>
        <p>Em breve você encontrará aqui todos os materiais para sua obra.</p>
      </div>
    </div>
    """
  end
end
