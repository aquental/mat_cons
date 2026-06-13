defmodule LojaWeb.HomeLive.Index do
  use LojaWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <div class="mx-auto max-w-7xl px-4 py-8">
      <!-- Hero -->
      <section class="mb-12 rounded-2xl bg-gradient-to-r from-blue-900 to-blue-700 p-8 text-white">
        <h1 class="mb-4 text-4xl font-bold">Materiais de construção com consultoria técnica</h1>
        <p class="mb-6 text-xl">
          Não sabe qual material comprar? Nosso consultor de obras com IA ajuda você
          a escolher os produtos certos para cada etapa da sua obra.
        </p>
        <a
          href="/consultor"
          class="inline-block rounded-lg bg-orange-500 px-6 py-3 font-semibold text-white hover:bg-orange-600"
        >
          Começar consulta →
        </a>
      </section>

      <!-- Categorias -->
      <section class="mb-12">
        <h2 class="mb-6 text-2xl font-bold text-gray-800">Categorias</h2>
        <div class="grid grid-cols-2 gap-4 md:grid-cols-4">
          <.category_card name="Hidráulica" icon="WaterIcon" />
          <.category_card name="Elétrica" icon="BoltIcon" />
          <.category_card name="Acabamento" icon="PaintBrushIcon" />
          <.category_card name="Estrutural" icon="BuildingOffice2Icon" />
        </div>
      </section>

      <!-- Destaques -->
      <section>
        <h2 class="mb-6 text-2xl font-bold text-gray-800">Produtos em Destaque</h2>
        <p class="text-gray-500">Em breve — catálogo sendo populado.</p>
      </section>
    </div>
    """
  end

  def category_card(assigns) do
    ~H"""
    <div class="rounded-xl bg-white p-6 text-center shadow-md transition hover:shadow-lg">
      <div class="mb-2 text-4xl">🏗️</div>
      <h3 class="font-semibold text-gray-800"><%= @name %></h3>
    </div>
    """
  end
end
