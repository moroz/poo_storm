defmodule PooStorm.Repo.Migrations.AddUrlToComments do
  use Ecto.Migration

  def change do
    execute "create extension if not exists citext with schema public"

    alter table(:comments) do
      add :url, :string, null: false
    end

    create index(:comments, [:url])
  end

  def down do
    alter table(:comments) do
      remove :url
    end
  end
end
