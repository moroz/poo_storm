defmodule PooStorm.CommentsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `PooStorm.Comments` context.
  """

  @doc """
  Generate a comment.
  """
  def comment_fixture(attrs \\ %{}) do
    {:ok, comment} =
      attrs
      |> Enum.into(%{
        body: "some body",
        remote_ip: "some remote_ip",
        signature: "some signature"
      })
      |> PooStorm.Comments.create_comment()

    comment
  end
end
