defmodule AlenxBlogEngine.Post do
  use AlenxBlogEngine.Web, :model

  schema "posts" do
    field :title, :string
    field :description, :string
    field :draft, :boolean, default: false
    belongs_to :user, AlenxBlogEngine.User

    timestamps()
  end
  
  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:user_id, :title, :description, :draft])
    |> validate_required([:user_id, :title, :description, :draft])
  end
end
