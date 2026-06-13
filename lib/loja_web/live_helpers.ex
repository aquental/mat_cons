defmodule LojaWeb.LiveHelpers do
  @moduledoc """
  Helper functions for LiveViews.
  """

  use Phoenix.Component

  import Phoenix.Component

  @doc """
  Renders a flash message.
  """
  attr :flash, :map, required: true, doc: "the flash map"
  attr :id, :string, default: "flash", doc: "the optional id of flash container"

  def flash(assigns) do
    ~H"""
    <div
      :if={live_flash = Phoenix.LiveView.flash(@flash, :info)}
      class="mb-4 rounded-lg bg-green-100 p-3 text-green-800"
    >
      <%= live_flash %>
    </div>
    <div
      :if={live_flash = Phoenix.LiveView.flash(@flash, :error)}
      class="mb-4 rounded-lg bg-red-100 p-3 text-red-800"
    >
      <%= live_flash %>
    </div>
    """
  end
end
