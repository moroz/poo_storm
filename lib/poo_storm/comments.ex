defmodule PooStorm.Comments do
  @moduledoc """
  The Comments context.
  """

  import Ecto.Query, warn: false
  alias PooStorm.Repo

  alias PooStorm.Comments.Comment
  alias PooStorm.CommentEmail

  def get_last_comment do
    Comment
    |> last
    |> Repo.one()
  end

  def list_comments do
    Repo.all(Comment)
  end

  def list_comments_by_url(url) do
    Comment
    |> where([c], c.url == ^url)
    |> order_by([c], desc: c.inserted_at)
    |> Repo.all()
  end

  def get_comment!(id), do: Repo.get!(Comment, id)

  def create_comment(attrs \\ %{}) do
    %Comment{}
    |> Comment.changeset(attrs)
    |> Repo.insert()
  end

  def update_comment(%Comment{} = comment, attrs) do
    comment
    |> Comment.changeset(attrs)
    |> Repo.update()
  end

  def send_comment_notification(comment) do
    comment
    |> CommentEmail.new_comment()
    |> PooStorm.Mailer.deliver()
  end

  @doc """
  Deletes a comment.

  ## Examples

      iex> delete_comment(comment)
      {:ok, %Comment{}}

      iex> delete_comment(comment)
      {:error, %Ecto.Changeset{}}

  """
  def delete_comment(%Comment{} = comment) do
    Repo.delete(comment)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking comment changes.

  ## Examples

      iex> change_comment(comment)
      %Ecto.Changeset{data: %Comment{}}

  """
  def change_comment(%Comment{} = comment, attrs \\ %{}) do
    Comment.changeset(comment, attrs)
  end
end
