defmodule AlenxBlogEngine.Post do
  use AlenxBlogEngine.Web, :model

  schema "posts" do
    field :title, :string
    field :description, :string
    field :draft, :boolean, default: false

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:title, :description, :draft])
    |> validate_required([:title, :description, :draft])
  end
end
