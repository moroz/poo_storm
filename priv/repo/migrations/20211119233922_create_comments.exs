defmodule PooStorm.Repo.Migrations.CreateComments do
  use Ecto.Migration

  def change do
    create table(:comments) do
      add :signature, :string, null: false
      add :body, :text, null: false
      add :remote_ip, :inet

      timestamps()
    end
  end
end
