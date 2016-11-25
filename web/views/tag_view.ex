defmodule AlenxBlogEngine.TagView do
  use AlenxBlogEngine.Web, :view

  def render("index.json", %{tags: tags, conn: conn}) do
    JaSerializer.format(AlenxBlogEngine.TagSerializer, tags, conn)
  end

  def render("show.json", %{tag: tag, conn: conn}) do
    JaSerializer.format(AlenxBlogEngine.TagSerializer, tag, conn)
  end

end
