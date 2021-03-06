defmodule AlenxBlogEngine.PostController do
  use AlenxBlogEngine.Web, :controller

  alias AlenxBlogEngine.{Post, PostHelper, EctoHelper}

  plug :scrub_params, "post" when action in [:create, :update]

  plug AlenxBlogEngine.Authentication when not action in [:index, :show]

  def index(conn, params) do
    query = from p in Post
    {posts, kerosene} = query
                        |> Repo.paginate(params)

    posts = Repo.preload(posts, :tags)

    render(conn, "index.json", posts: posts, kerosene: kerosene)
  end

  def create(conn, %{"post" => post_params}) do
    changeset = Post.changeset(
      %Post{user_id: conn.assigns.current_user.id}, post_params
    )

    case Repo.insert(changeset) do
      {:ok, post} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", post_path(conn, :show, post))
        |> render("show.json", post: post)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(AlenxBlogEngine.ChangesetView, "error.json", changeset: changeset)
    end
  end

end