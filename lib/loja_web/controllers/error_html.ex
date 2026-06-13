defmodule LojaWeb.ErrorHTML do
  use LojaWeb, :html

  embed_templates "error_html/*"

  def render(assigns) do
    ~H"""
    <div class="flex min-h-screen items-center justify-center">
      <div class="text-center">
        <h1 class="text-6xl font-bold text-gray-300"><%= @status %></h1>
        <p class="mt-2 text-gray-600">Algo deu errado.</p>
      </div>
    </div>
    """
  end
end
