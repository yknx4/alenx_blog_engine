defmodule AlenxBlogEngine.PostHelper do
    import Ecto.Query
    alias AlenxBlogEngine.{Repo}

    def get_tags(post) when is_map(post) do
      post = Repo.preload(post, :tags)
      Enum.map(post.tags, &(&1.id))
    end
end