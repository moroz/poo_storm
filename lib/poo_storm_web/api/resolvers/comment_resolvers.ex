defmodule PooStormWeb.Api.CommentResolvers do
  alias PooStorm.Comments

  def list_comments(_, _) do
    {:ok, Comments.list_comments()}
  end
end
