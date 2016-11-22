defmodule AlenxBlogEngine.PostTest do
  use AlenxBlogEngine.ModelCase
  import AlenxBlogEngine.Factory

  alias AlenxBlogEngine.Post

  defp valid_attrs do
    params_with_assocs(:post) |> Map.delete(:inserted_at) |> Map.delete(:updated_at)
  end
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Post.changeset(%Post{}, valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Post.changeset(%Post{}, @invalid_attrs)
    refute changeset.valid?
  end
end
