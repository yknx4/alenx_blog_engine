defmodule AlenxBlogEngine.PostTag do
  use AlenxBlogEngine.Web, :model

  @primary_key false
  schema "post_tags" do
    belongs_to :post, AlenxBlogEngine.Post
    belongs_to :tag, AlenxBlogEngine.Tag

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:post_id, :tag_id])
    |> validate_required([:post_id, :tag_id])
  end
end
