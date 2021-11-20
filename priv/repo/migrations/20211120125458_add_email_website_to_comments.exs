defmodule PooStorm.Repo.Migrations.AddEmailWebsiteToComments do
  use Ecto.Migration

  def change do
    alter table(:comments) do
      add :email, :string, null: false
      add :website, :string
    end
  end
end
