defmodule AlenxBlogEngine.Repo.Migrations.UpdatePostsTable do
  use Ecto.Migration

  def change do
    alter table(:posts) do
      add :former_permalink, :string
    end
    rename table(:posts), :description, to: :body
  end
end
