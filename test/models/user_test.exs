defmodule AlenxBlogEngine.UserTest do
  use AlenxBlogEngine.ModelCase

  alias AlenxBlogEngine.User
  import AlenxBlogEngine.Factory

  test "changeset with valid attributes" do
    changeset = User.changeset(%User{}, params_for(:user))
    assert changeset.valid?
  end

  test "changeset, email too short " do
    changeset = User.changeset(
      %User{}, Map.put(params_for(:user), :email, "")
    )
    refute changeset.valid?
  end

  test "changeset, email invalid format" do
    changeset = User.changeset(
      %User{}, Map.put(params_for(:user), :email, "foo.com")
    )
    refute changeset.valid?
  end

  test "registration_changeset" do
    changeset = User.registration_changeset(%User{}, params_for(:user))
    assert changeset.changes.password_hash
    assert changeset.valid?
  end

  test "registration_changeset, password too short" do
    changeset = User.registration_changeset(
      %User{}, Map.put(params_for(:user), :password, "12345")
    )
    refute changeset.valid?
  end
end