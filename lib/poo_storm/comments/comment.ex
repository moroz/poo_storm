defmodule PooStorm.Comments.Comment do
  use Ecto.Schema
  import Ecto.Changeset
  import PooStorm.ValidationHelpers

  @required ~w(body signature url email)a
  @cast @required ++ [:remote_ip, :website]

  schema "comments" do
    field :body, :string
    field :remote_ip, EctoNetwork.INET
    field :signature, :string
    field :url, :string
    field :website, :string
    field :email, :string

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

  defp validate_website(changeset) do
    case get_change(changeset, :website) do
      nil ->
        changeset

      url ->
        if is_valid_website?(url) do
          changeset
        else
          put_change(changeset, :website, "is not a valid website URL")
        end
    end
  end
end
