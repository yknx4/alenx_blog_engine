defmodule AlenxBlogEngine.PostControllerTest do
  use AlenxBlogEngine.ConnCase

  alias AlenxBlogEngine.Post
  alias AlenxBlogEngine.User
  alias AlenxBlogEngine.Session

  @valid_attrs %{draft: false, description: "some content", title: "some title"}
  @invalid_attrs %{}

  setup %{conn: conn} do
    user = create_user(%{name: "jane"})
    session = create_session(user)

    conn = conn
    |> put_req_header("accept", "application/json")
    |> put_req_header("authorization", "Token token=\"#{session.token}\"")
    {:ok, conn: conn, current_user: user }
  end

  def create_user(%{name: name}) do
    User.changeset(%User{}, %{email: "#{name}@example.com", password: "password", username: "foobar#{name}"}) |> Repo.insert!
  end

  def create_session(user) do
    # in the last blog post I had a copy-paste error
    # so you may need to use Session.registration_changeset
    Session.create_changeset(%Session{user_id: user.id}, %{}) |> Repo.insert!
  end

  def create_post(%{description: _description, user_id: _user_id} = options) do
    Post.changeset(%Post{}, options) |> Repo.insert!
  end

  test "lists all entries on index", %{conn: conn, current_user: current_user} do
    create_post(%{title: "first", description: "our first post", user_id: current_user.id})

    another_user = create_user(%{name: "johndoe"})
    create_post(%{title: "second", description: "thier first post", user_id: another_user.id})

    conn = get conn, post_path(conn, :index)

    assert Enum.count(json_response(conn, 200)["data"]) == 1
    assert %{"description" => "our first post"} = hd(json_response(conn, 200)["data"])
  end

  test "creates and renders resource when data is valid", %{conn: conn, current_user: current_user} do
    conn = post conn, post_path(conn, :create), post: @valid_attrs
    post = Repo.get_by(Post, @valid_attrs)
    assert post
    assert post.user_id == current_user.id
  end

end