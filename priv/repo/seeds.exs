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
    @tags []
    def new_tag do
        Repo.insert! %Tag{
            name: "#{Faker.Lorem.word} #{Faker.Lorem.word} #{Faker.Lorem.word}"
        }
    end

    def get_tag do
        if Enum.count(@tags) < 10 do
            @tags ++ List.wrap(new_tag)
        end
        Enum.take_random(@tags, 1) |> List.first
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

    def with_tag(post) do
        Repo.insert %PostTag{
            post: post,
            tag: get_tag
        }
        post
    end
end
alias AlenxBlogEngine.Seeds

user = Seeds.new_user

for _ <- 1..1000 do 
    Seeds.new_post(user) |> Seeds.with_tag |> Seeds.with_tag
end