defmodule PooStormWeb.Api.CommentResolvers do
  alias PooStorm.Comments

  def list_comments(%{url: url}, _) do
    {:ok, Comments.list_comments_by_url(url)}
  end

  def create_comment(%{input: params}, _) do
    Comments.create_comment(params)
  end
end
