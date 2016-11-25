defmodule AlenxBlogEngine.Repo do
  use Ecto.Repo, otp_app: :alenx_blog_engine
  use Kerosene, per_page: 10
end
