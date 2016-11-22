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
alias AlenxBlogEngine.{Repo, User, Post}
Faker.start

defmodule AlenxBlogEngine.Seeds do
    def new_post(user) do
        AlenxBlogEngine.Repo.insert! %Post{
         user: user,
         title: Faker.Lorem.sentence(%Range{first: 1, last: 10}),
         body: Faker.Lorem.paragraph(%Range{first: 1, last: 2}),
         draft: false
        }
    end
end

password = "pa4ssw0rd"
    
user = AlenxBlogEngine.Repo.insert! %User{
      email: Faker.Internet.email,
      username: Faker.Internet.user_name,
      password: password,
      password_hash: Comeonin.Bcrypt.hashpwsalt(password)
    }

for _ <- 1..1000 do 
    AlenxBlogEngine.Seeds.new_post(user)
end