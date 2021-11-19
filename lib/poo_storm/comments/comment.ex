defmodule PooStorm.Comments.Comment do
  use Ecto.Schema
  import Ecto.Changeset

  schema "comments" do
    field :body, :string
    field :remote_ip, EctoNetwork.INET
    field :signature, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(comment, attrs) do
    comment
    |> cast(attrs, [:signature, :body, :remote_ip])
    |> validate_required([:signature, :body, :remote_ip])
  end
end
