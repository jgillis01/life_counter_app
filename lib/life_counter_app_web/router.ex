defmodule LifeCounterAppWeb.Router do
  use LifeCounterAppWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", LifeCounterAppWeb do
    pipe_through :browser # Use the default browser stack

    get "/", GameController, :index

    resources "/sessions", SessionController, only: [:new, :create, :delete]
    resources "/player", PlayerController, only: [:update]
    #resources "/game", GameController, only: [:new, :create, :index]
  end

  # Other scopes may use custom stacks.
  # scope "/api", LifeCounterAppWeb do
  #   pipe_through :api
  # end
end
