defmodule AlenxBlogEngine.Repo.Migrations.CreatePost do
  use Ecto.Migration

  def change do
    create table(:posts) do
      add :title, :string
      add :description, :string
      add :draft, :boolean, default: false, null: false

      timestamps()
    end

  end
end
