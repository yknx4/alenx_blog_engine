defmodule AlenxBlogEngine.PaginationHelper do
  def kerosene_to_jsonapi(kerosene) do
    Enum.map(kerosene, &(switch_format(&1)))
  end

  defp switch_format(page) do
    key = page.label
          |> String.downcase
          |> String.to_atom
    {key, page.url}
  end
end
