defmodule AlenxBlogEngine.Factory do
  alias AlenxBlogEngine.{Repo, User, Post}
  use ExMachina.Ecto, repo: Repo

  def post_factory do
    %Post{
      user: build(:user),
      title: sequence(:title, &"title-#{&1}"),
      description: "description",
      draft: false
    }
  end

  def user_factory do
    password = "pa4ssw0rd"
    %User{
      email: sequence(:email, &"email-#{&1}@example.com"),
      username: sequence(:username, &"user#{&1}"),
      password: "pa4ssw0rd",
      password_hash: Comeonin.Bcrypt.hashpwsalt(password)
    }
  end
end