defmodule AlenxBlogEngine.Factory do
  alias AlenxBlogEngine.{Repo, User, Post, Session, Tag, PostTag}
  use ExMachina.Ecto, repo: Repo

  def post_tag_factory do
    %PostTag{
      post: build(:post),
      tag: build(:tag)
    }  
  end

  def tag_factory do
    %Tag{
      name: Faker.Lorem.word
    }
  end
  
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

  def with_tags(post) do
    insert(:post_tag, post: post)
    insert(:post_tag, post: post)
    post
  end

  def user_factory do
    password = "pa4ssw0rd"
    %User{
      email: Faker.Internet.email,
      username: Faker.Internet.user_name,
      password: password,
      password_hash: Comeonin.Bcrypt.hashpwsalt(password)
    }
  end
end