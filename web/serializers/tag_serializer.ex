defmodule AlenxBlogEngine.TagSerializer do
  use JaSerializer

  location "/tags/:id"
  attributes [:id, :name]

end