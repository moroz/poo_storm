defmodule PooStorm.Repo.Migrations.AddUrlToComments do
  use Ecto.Migration

  def change do
    alter table(:comments) do
      add :url, :string, null: false
    end

    create index(:comments, [:url])
  end
end
