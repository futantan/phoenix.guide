defmodule HelloWeb.Router do
  use HelloWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug Locale.Plug, "en"
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", HelloWeb do
    pipe_through :browser

    get "/", PageController, :index
    get "/hello", HelloController, :index
    get "/hello/:messenger", HelloController, :show
    resources "/users", UserController do
      resources "/posts", PostController
    end
  end

  forward "/jobs", BackgroundJob.Plug

  # Other scopes may use custom stacks.
  # scope "/api", HelloWeb do
  #   pipe_through :api
  # end
end
