defmodule AlenxBlogEngine.PostView do
  use AlenxBlogEngine.Web, :view

  def render("index.json", %{posts: posts}) do
    %{data: render_many(posts, AlenxBlogEngine.PostView, "post.json")}
  end

  def render("show.json", %{post: post}) do
    %{data: render_one(post, AlenxBlogEngine.PostView, "post.json")}
  end

  def render("post.json", %{post: post}) do
    %{
      id: post.id,
      user_id: post.user_id,
      title: post.title,
      body: post.body,
      draft: post.draft,
      tags: AlenxBlogEngine.PostHelper.get_tags(post)
    }
  end
end
