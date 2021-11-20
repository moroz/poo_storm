defmodule PooStorm.Comments.Comment do
  use Ecto.Schema
  import Ecto.Changeset

  @required ~w(body signature url)a
  @cast @required ++ [:remote_ip]

  schema "comments" do
    field :body, :string
    field :remote_ip, EctoNetwork.INET
    field :signature, :string
    field :url, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(comment, attrs) do
    comment
    |> cast(attrs, @cast)
    |> validate_required(@required)
    |> validate_url()
  end

  defp validate_url(changeset) do
    case get_change(changeset, :url) do
      nil ->
        changeset

      url ->
        parsed = URI.parse(url)
        put_change(changeset, :url, parsed.path)
    end
  end
end
