defmodule AlenxBlogEngine.Repo.Migrations.CreatePostTag do
  use Ecto.Migration

  def change do
    create table(:post_tags) do
      add :post_id, references(:posts, on_delete: :nothing)
      add :tag_id, references(:tags, on_delete: :nothing)

      timestamps()
    end
    create index(:post_tags, [:post_id])
    create index(:post_tags, [:tag_id])

  end
end
