defmodule LojaWeb.ProductLive.Show do
  use LojaWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, product: nil, loading: true)}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <div class="mx-auto max-w-6xl px-4 py-8">
      <div class="grid gap-8 md:grid-cols-2">
        <!-- Imagem -->
        <div class="flex items-center justify-center rounded-xl bg-gray-100 p-12">
          <span class="text-6xl">📦</span>
        </div>

        <!-- Info -->
        <div>
          <p class="text-sm text-gray-500">Carregando produto...</p>
        </div>
      </div>
    </div>
    """
  end
end
