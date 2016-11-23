defmodule AlenxBlogEngine.TagTest do
  use AlenxBlogEngine.ModelCase
  import AlenxBlogEngine.Factory

  alias AlenxBlogEngine.Tag

  @valid_attrs params_for(:tag) |> Map.delete(:inserted_at) |> Map.delete(:updated_at)
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Tag.changeset(%Tag{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Tag.changeset(%Tag{}, @invalid_attrs)
    refute changeset.valid?
  end
end
