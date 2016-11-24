defmodule AlenxBlogEngine.PostHelper do
    import Ecto.Query
    alias AlenxBlogEngine.{Repo, PostTag}

    def with_tags(post) when is_map(post) do
        Map.put_new(post, "tag_ids", get_tags(post))
    end

    def with_tags(posts) when is_list(posts) do
        Enum.map(posts, &(with_tags/1))
    end

    def get_tags(posts) when is_list(posts) do
        Stream.transform(posts, %{}, &(Map.put(&2, &1.id, get_tags(&1.id))))
    end

    def get_tags(post) when is_map(post) do
        if Map.has_key?(post, "tag_ids") do
          post["tag_ids"]
        else
          get_tags(post.id)
        end
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