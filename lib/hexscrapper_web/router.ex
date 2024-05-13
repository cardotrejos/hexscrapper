defmodule HexscrapperWeb.Router do
  use HexscrapperWeb, :router


  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, html: {HexscrapperWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end


  scope "/", HexscrapperWeb do
    pipe_through :browser

    live "/pages", PageLive.Index, :index
    live "/pages/:id", PageLive.Show, :show
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", HexscrapperWeb do
    pipe_through :api

    post "/register", UserController, :register
    post "/login", UserController, :login
    post "/pages", PageController, :create
    get "/pages", PageController, :index
    get "/pages/:id", PageController, :show
  end
end
