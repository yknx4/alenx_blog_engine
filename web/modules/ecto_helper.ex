defmodule AlenxBlogEngine.EctoHelper do
    def wrap_like_query(data) when is_list(data) do
        %{"data" => data}
    end
end