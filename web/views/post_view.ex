defmodule AlenxBlogEngine.PostView do
  use AlenxBlogEngine.Web, :view
  import Kerosene.JSON
  alias AlenxBlogEngine.{PostHelper, PostView, PaginationHelper, PostSerializer}

  def render("index.json", %{posts: posts, kerosene: kerosene, conn: conn}) do
    pagination = paginate(conn, kerosene, previous_label: "Prev", window: 1)
                 |> PaginationHelper.kerosene_to_jsonapi

    posts = JaSerializer.format(PostSerializer, posts, conn, page: pagination)
  end

  def render("show.json", %{post: post}) do
    %{data: render_one(post, PostView, "post.json")}
  end

end
