defmodule LojaWeb.Admin.ObraRulesLive.Index do
  use LojaWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, rules: [])}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <div class="p-6">
      <h1 class="mb-6 text-2xl font-bold text-gray-800">Regras do Consultor</h1>

      <div class="rounded-xl bg-white p-6 shadow">
        <p class="text-gray-500">
          Configure aqui as regras de domínio que o Consultor de Obras usa
          para sugerir materiais. Adicione tipos de obra, materiais compatíveis
          e fórmulas de cálculo de quantidade.
        </p>
      </div>

      <!-- Placeholder para lista de regras -->
      <div class="mt-4 rounded-xl bg-white p-6 shadow">
        <p class="text-gray-500">Nenhuma regra cadastrada ainda.</p>
      </div>
    </div>
    """
  end
end
