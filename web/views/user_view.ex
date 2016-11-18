defmodule AlenxBlogEngine.UserView do
  use AlenxBlogEngine.Web, :view

  def render("show.json", %{user: user}) do
    %{data: render_one(user, AlenxBlogEngine.UserView, "user.json")}
  end

  def render("user.json", %{user: user}) do
    %{id: user.id,
      username: user.username,
      email: user.email}
  end
end