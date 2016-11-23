defmodule AlenxBlogEngine.PostTagTest do
  use AlenxBlogEngine.ModelCase
  import AlenxBlogEngine.Factory

  alias AlenxBlogEngine.PostTag

  defp valid_attrs do
    params_with_assocs(:post_tag) |> Map.delete(:inserted_at) |> Map.delete(:updated_at)
  end
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = PostTag.changeset(%PostTag{}, valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = PostTag.changeset(%PostTag{}, @invalid_attrs)
    refute changeset.valid?
  end
end
