defmodule AlenxBlogEngine.UserControllerTest do
  use AlenxBlogEngine.ConnCase
  alias AlenxBlogEngine.User
  import AlenxBlogEngine.Factory

  @valid_attrs params_for(:user) |> Map.delete(:inserted_at) |> Map.delete(:updated_at)
  @invalid_attrs %{}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, user_path(conn, :create), user: @valid_attrs
    body = json_response(conn, 201)
    assert body["data"]["id"]
    assert body["data"]["email"]
    assert body["data"]["username"]
    refute body["data"]["password"]
    assert Repo.get_by(User, email: @valid_attrs[:email])
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, user_path(conn, :create), user: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

end