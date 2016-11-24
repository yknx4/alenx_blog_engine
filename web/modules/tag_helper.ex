defmodule AlenxBlogEngine.TagHelper do
    import Ecto.Query
    alias AlenxBlogEngine.{Repo, PostTag}

    def get_tags(post) when is_map(post) do
        get_tags(post.id)
    end

    def get_tags(post_id) when is_integer(post_id) do
        query = from pt in PostTag, select: pt.tag_id, where: pt.post_id == ^post_id
        Repo.all(query)
    end
    
    def get_tags(post, tags) when is_map(post) and is_map(tags) do
        get_tags(post.id, tags)
    end

    def get_tags(post_id, tags) when is_integer(post_id) and is_map(tags) do
        if Map.has_key?(tags, post_id) do
            tags[post_id]
        else
            get_tags(post_id)
        end
    end
end