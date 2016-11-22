defmodule AlenxBlogEngine.Factory do
  alias AlenxBlogEngine.{Repo, User, Post, Session}
  use ExMachina.Ecto, repo: Repo

  def session_factory do
    %Session{
      user: build(:user),
      token: SecureRandom.urlsafe_base64
    }
  end

  def post_factory do
    %Post{
      user: build(:user),
      title: Faker.Lorem.sentence(%Range{first: 1, last: 10}),
      body: Faker.Lorem.paragraph(%Range{first: 1, last: 2}),
      draft: false
    }
  end

  def user_factory do
    password = "pa4ssw0rd"
    %User{
      email: Faker.Internet.email,
      username: Faker.Internet.user_name,
      password: "pa4ssw0rd",
      password_hash: Comeonin.Bcrypt.hashpwsalt(password)
    }
  end
end