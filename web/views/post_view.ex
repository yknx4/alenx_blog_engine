defmodule AlenxBlogEngine.PostView do
  use AlenxBlogEngine.Web, :view

  def render("index.json", %{posts: posts}) do
    %{data: render_many(posts, AlenxBlogEngine.PostView, "post.json")}
  end

  def render("show.json", %{post: post}) do
    %{data: render_one(post, AlenxBlogEngine.PostView, "post.json")}
  end

  def render("post.json", %{post: post}) do
    %{id: post.id,
      title: post.title,
      description: post.description,
      draft: post.draft}
  end
end
