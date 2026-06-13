defmodule LojaWeb.PageController do
  use LojaWeb, :controller

  def home(conn, _params) do
    render(conn, :home)
  end
end
