defmodule PooStormWeb.Api.CommentResolvers do
  alias PooStorm.Comments
  alias PooStorm.Comments.Comment
  alias PooStormWeb.MarkdownHelpers

  def list_comments(%{url: url}, _) do
    {:ok, Comments.list_comments_by_url(url)}
  end

  def create_comment(%{input: params}, _) do
    Comments.create_comment(params)
  end

  def resolve_body(%Comment{body: body}, %{format: :raw}, _) do
    {:ok, body}
  end

  def resolve_body(%Comment{body: body}, %{format: :markdown}, _) do
    {:ok, MarkdownHelpers.render_markdown_to_safe_html(body)}
  end
end
