# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     AlenxBlogEngine.Repo.insert!(%AlenxBlogEngine.SomeModel{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
alias AlenxBlogEngine.{Repo, User, Post, Tag, PostTag}
Faker.start

defmodule AlenxBlogEngine.Seeds do

    def random_string(length) do
      :crypto.strong_rand_bytes(length) |> Base.url_encode64 |> binary_part(0, length)
    end

    def new_tag do
        Repo.insert! %Tag{
            name: "#{Faker.Commerce.product_name_adjective} #{random_string(8)}"
        }
    end

    def generate_tags(number) do
        Enum.map(1..number, fn(_) -> new_tag end)
    end

    def get_tag(tags) do
        Enum.take_random(tags, 1) |> List.first
    end

    def new_user do
        Repo.insert! %User{
            email: Faker.Internet.email,
            username: Faker.Internet.user_name,
            password: "p4asw0ord",
            password_hash: Comeonin.Bcrypt.hashpwsalt("p4asw0ord")
        }
    end

    def new_post(user) do
        Repo.insert! %Post{
         user: user,
         title: Faker.Lorem.sentence(%Range{first: 1, last: 10}),
         body: Faker.Lorem.paragraph(%Range{first: 1, last: 2}),
         draft: false
        }
    end

    def with_tags(post, tags) do
        with_tags(post, tags, :rand.uniform(3))
    end

    def with_tags(post, tags, number) do
        for _ <- 1..number do with_tag(post, tags) end
        post
    end

    def with_tag(post, tags) do
        Repo.insert %PostTag{
            post: post,
            tag: get_tag(tags)
        }
        post
    end
end
alias AlenxBlogEngine.Seeds

user = Seeds.new_user
tags = Seeds.generate_tags(50)

for _ <- 1..1000 do 
    Seeds.new_post(user) |> Seeds.with_tags(tags)
end