defmodule AlenxBlogEngine.Repo.Migrations.AddUserIdToPost do
  use Ecto.Migration

  def change do
    alter table(:posts) do
      add :user_id, references(:users, on_delete: :nilify_all)
    end
  end
end
