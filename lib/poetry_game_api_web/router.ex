defmodule PoetryGameApiWeb.Router do
  use PoetryGameApiWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", PoetryGameApiWeb do
    pipe_through :api
    resources "/poems", PoemController, except: [:new, :edit, :update]
  end
end
