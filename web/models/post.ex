defmodule AlenxBlogEngine.Post do
  use AlenxBlogEngine.Web, :model

  schema "posts" do
    field :title, :string
    field :body, :string
    field :draft, :boolean, default: false

    belongs_to :user, AlenxBlogEngine.User
    many_to_many :tags, AlenxBlogEngine.Post, join_through: AlenxBlogEngine.PostTag

    timestamps()
  end
  
  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:user_id, :title, :body, :draft])
    |> validate_required([:user_id, :title, :body, :draft])
  end
end
