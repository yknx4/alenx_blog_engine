defmodule AlenxBlogEngine.SessionTest do
  use AlenxBlogEngine.ModelCase
  import AlenxBlogEngine.Factory

  alias AlenxBlogEngine.Session

  defp valid_attrs do
    params_with_assocs(:session) |> Map.delete(:inserted_at) |> Map.delete(:updated_at)
  end
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Session.changeset(%Session{}, valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Session.changeset(%Session{}, @invalid_attrs)
    refute changeset.valid?
  end

  test "create_changeset with valid attributes" do
    changeset = Session.create_changeset(%Session{}, valid_attrs)
    assert changeset.changes.token
    assert changeset.valid?
  end

  test "create_changeset with invalid attributes" do
    changeset = Session.create_changeset(%Session{}, @invalid_attrs)
    refute changeset.valid?
  end
end