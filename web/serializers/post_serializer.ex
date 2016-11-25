defmodule AlenxBlogEngine.PostSerializer do
  use JaSerializer

  location "/posts/:id"
  attributes [:id, :title, :body, :user_id, :created_at, :updated_at, :excerpt, :tag_ids]

  def excerpt(post, _conn) do
    [first | _ ] = String.split(post.body, ".")
    first
  end

  def tag_ids(post, _conn) do
    AlenxBlogEngine.PostHelper.get_tags(post)
  end
end