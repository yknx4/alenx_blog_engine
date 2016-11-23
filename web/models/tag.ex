defmodule AlenxBlogEngine.Tag do
  use AlenxBlogEngine.Web, :model

  schema "tags" do
    field :name, :string
    
    many_to_many :posts, AlenxBlogEngine.Tag, join_through: AlenxBlogEngine.PostTag

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name])
    |> validate_required([:name])
    |> unique_constraint(:name)
  end
end
