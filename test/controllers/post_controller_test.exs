defmodule AlenxBlogEngine.PostControllerTest do
  use AlenxBlogEngine.ConnCase
  import AlenxBlogEngine.Factory

  alias AlenxBlogEngine.{Post, User, Session}

  @valid_attrs params_for(:post) |> Map.delete(:user_id) |> Map.delete(:inserted_at) |> Map.delete(:updated_at)
  @invalid_attrs %{}

  setup %{conn: conn} do
    user = insert(:user)
    session = insert(:session, user: user)

    conn = conn
    |> put_req_header("accept", "application/json")
    |> put_req_header("authorization", "Token token=\"#{session.token}\"")
    {:ok, conn: conn, current_user: user }
  end

  test "lists all entries on index", %{conn: conn, current_user: current_user} do
    insert(:post, user: current_user)

    another_user = insert(:user)
    insert(:post, user: another_user)

    conn = get conn, post_path(conn, :index)

    assert Enum.count(json_response(conn, 200)["data"]) == 2
  end

  test "creates and renders resource when data is valid", %{conn: conn, current_user: current_user} do
    conn = post conn, post_path(conn, :create), post: @valid_attrs
    post = Repo.get_by(Post, @valid_attrs)
    assert post
    assert post.user_id == current_user.id
  end

end