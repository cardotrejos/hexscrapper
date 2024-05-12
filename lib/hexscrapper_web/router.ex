defmodule HexscrapperWeb.Router do
  use HexscrapperWeb, :router

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
