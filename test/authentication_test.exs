defmodule AlenxBlogEngine.AuthenticationTest do
  use AlenxBlogEngine.ConnCase

  alias AlenxBlogEngine.{Authentication, Repo, User, Session}

  @opts Authentication.init([])
  @valid_attrs %{email: "foo@bar.com", password: "s3cr3t", username: "foobar"}

  def put_auth_token_in_header(conn, token) do
    conn
    |> put_req_header("authorization", "Token token=\"#{token}\"")
  end

  test "finds the user by token", %{conn: conn} do
    changeset =  User.registration_changeset(%User{}, @valid_attrs)
    user = Repo.insert!(changeset)
    session = Repo.insert!(%Session{token: "123", user_id: user.id})

    conn = conn
    |> put_auth_token_in_header(session.token)
    |> Authentication.call(@opts)

    assert conn.assigns.current_user
  end

  test "invalid token", %{conn: conn} do
    conn = conn
    |> put_auth_token_in_header("foo")
    |> Authentication.call(@opts)

    assert conn.status == 401
    assert conn.halted
  end

  test "no token", %{conn: conn} do
    conn = Authentication.call(conn, @opts)
    assert conn.status == 401
    assert conn.halted
  end
end
