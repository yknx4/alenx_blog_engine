defmodule AlenxBlogEngine.Router do
  use AlenxBlogEngine.Web, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", AlenxBlogEngine do
    pipe_through :api

    resources "/users", UserController, only: [:create]
    resources "/posts", PostController, except: [:new, :edit]
    resources "/sessions", SessionController, only: [:create]
    resources "/tags", TagController
  end
end
