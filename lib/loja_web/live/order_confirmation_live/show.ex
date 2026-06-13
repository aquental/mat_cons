defmodule LojaWeb.OrderConfirmationLive.Show do
  use LojaWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, order: nil)}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <div class="mx-auto max-w-2xl px-4 py-8 text-center">
      <div class="mb-4 text-6xl">✅</div>
      <h1 class="mb-2 text-3xl font-bold text-gray-800">Pedido Confirmado!</h1>
      <p class="text-gray-600">
        Seu pedido foi registrado. Em breve entraremos em contato para acertar o pagamento.
      </p>
    </div>
    """
  end
end
