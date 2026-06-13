defmodule LojaWeb.Router do
  use LojaWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {LojaWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  ## Catálogo (Público)

  scope "/", LojaWeb do
    pipe_through :browser

    live "/", HomeLive.Index, :index
    live "/catalogo", CatalogLive.Index, :index
    live "/produto/:slug", ProductLive.Show, :show
  end

  ## Carrinho

  scope "/carrinho", LojaWeb do
    pipe_through :browser

    live "/", CartLive.Index, :index
    live "/checkout", CheckoutLive.Index, :index
    live "/confirmacao/:order_id", OrderConfirmationLive.Show, :show
  end

  ## Consultor IA

  scope "/consultor", LojaWeb do
    pipe_through :browser

    live "/", ConsultantLive.Index, :index
  end

  ## Admin

  scope "/admin", LojaWeb.Admin do
    pipe_through :browser
    import AshAdmin.Router

    ash_admin "/"
    live "/dashboard", DashboardLive.Index, :index
    live "/regras", ObraRulesLive.Index, :index
  end

  # API - not yet active (waiting for ash_json_api compatibility)

  # scope "/api", LojaWeb.Api do
  #   pipe_through :api
  #   # ash_json_api "/"
  # end

  scope "/" do
    pipe_through :browser
    get "/robots.txt", LojaWeb.RobotsTxtController, :index
  end
end
