defmodule AlenxBlogEngine.TagView do
  use AlenxBlogEngine.Web, :view

  def render("index.json", %{tags: tags}) do
    %{data: render_many(tags, AlenxBlogEngine.TagView, "tag.json")}
  end

  def render("show.json", %{tag: tag}) do
    %{data: render_one(tag, AlenxBlogEngine.TagView, "tag.json")}
  end

  def render("tag.json", %{tag: tag}) do
    %{id: tag.id,
      name: tag.name}
  end
end
