defmodule AlenxBlogEngine.PostView do
  use AlenxBlogEngine.Web, :view
  import Kerosene.JSON
  alias AlenxBlogEngine.{PostHelper, PostView, PaginationHelper, PostSerializer}

  def render("index.json", %{posts: posts, kerosene: kerosene, conn: conn}) do
    pagination = paginate(conn, kerosene)
                 |> PaginationHelper.kerosene_to_jsonapi

    posts = posts
            |> PostSerializer.format(conn, page: pagination)
  end

  def render("show.json", %{post: post}) do
    %{data: render_one(post, PostView, "post.json")}
  end

end
