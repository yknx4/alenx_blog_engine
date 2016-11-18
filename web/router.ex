defmodule AlenxBlogEngine.Router do
  use AlenxBlogEngine.Web, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", AlenxBlogEngine do
    pipe_through :api

    resources "/posts", PostController, except: [:new, :edit]
  end
end
