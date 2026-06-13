defmodule LojaWeb.ConsultantLive.Index do
  use LojaWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, messages: [], input: "", loading: false)}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <div class="mx-auto max-w-4xl px-4 py-8">
      <div class="mb-6">
        <h1 class="text-3xl font-bold text-gray-800">Consultor de Obras</h1>
        <p class="mt-1 text-gray-600">
          Descreva sua obra e o consultor sugere os materiais certos.
        </p>
      </div>

      <!-- Chat -->
      <div class="mb-4 h-96 overflow-y-auto rounded-xl border bg-gray-50 p-4">
        <div class="flex items-start gap-3">
          <div class="flex h-10 w-10 items-center justify-center rounded-full bg-blue-100 text-lg">
            🤖
          </div>
          <div class="max-w-[80%] rounded-lg bg-blue-100 p-3">
            <p class="text-sm text-gray-700">
              Olá! Eu sou o consultor de obras da LOJA. Me conte o que você precisa:
              qual cômodo, tamanho, e o que deseja fazer (assentar piso, rebocar parede,
              instalar hidráulica, etc.).
            </p>
          </div>
        </div>
      </div>

      <!-- Input -->
      <div class="flex gap-2">
        <input
          type="text"
          placeholder="Ex: vou assentar porcelanato 60x60 na sala de 25m²"
          class="flex-1 rounded-lg border border-gray-300 p-3"
        />
        <button class="rounded-lg bg-orange-500 px-6 py-3 font-semibold text-white hover:bg-orange-600">
          Enviar
        </button>
      </div>
    </div>
    """
  end
end
