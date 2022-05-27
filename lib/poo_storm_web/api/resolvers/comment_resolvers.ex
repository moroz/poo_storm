defmodule PooStormWeb.Api.CommentResolvers do
  alias PooStorm.Comments
  alias PooStorm.Comments.Comment
  alias PooStormWeb.MarkdownHelpers

  def list_comments(%{url: url}, _) do
    {:ok, Comments.list_comments_by_url(url)}
  end

  def create_comment(%{input: %{i_am_a_robot: true}}, _) do
    {:error, "We are sorry, but the service is currently only available to humans."}
  end

  def create_comment(%{input: params}, _) do
    with {:ok, comment} <- Comments.create_comment(params) do
      Task.start(fn -> Comments.send_comment_notification(comment) end)
      {:ok, %{success: true, data: comment}}
    end
  end

  def resolve_body(%Comment{body: body}, %{format: :raw}, _) do
    {:ok, body}
  end

  def resolve_body(%Comment{body: body}, %{format: :markdown}, _) do
    {:ok, MarkdownHelpers.render_markdown_to_safe_html(body)}
  end
end
