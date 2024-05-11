defmodule HexscrapperWeb.Router do
  use HexscrapperWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", HexscrapperWeb do
    pipe_through :api

    post "/register", UserController, :register
    post "/login", UserController, :login
  end
end
