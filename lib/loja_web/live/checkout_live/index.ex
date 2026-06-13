defmodule LojaWeb.CheckoutLive.Index do
  use LojaWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, step: :review, contact: %{}, cep: "", shipping: nil)}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <div class="mx-auto max-w-2xl px-4 py-8">
      <h1 class="mb-6 text-3xl font-bold text-gray-800">Finalizar Pedido</h1>
      <p class="text-gray-500">Adicione produtos ao carrinho para finalizar.</p>
    </div>
    """
  end
end
