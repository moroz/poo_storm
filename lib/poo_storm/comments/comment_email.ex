defmodule PooStorm.CommentEmail do
  use Phoenix.Swoosh, view: PooStormWeb.MailerView, layout: {PooStormWeb.LayoutView, :email}

  alias PooStorm.Comments.Comment

  defp config, do: Application.get_env(:poo_storm, PooStorm.Mailer)

  defp recipient, do: config() |> Keyword.get(:recipient)
  defp sender, do: config() |> Keyword.get(:sender)
  defp website_url, do: config() |> Keyword.get(:website_url)

  def new_comment(%Comment{} = comment) do
    new()
    |> to(recipient())
    |> from(sender())
    |> subject("#{comment.signature} posted a new comment on your website")
    |> render_body("new_comment.html", %{comment: comment, website_url: website_url()})
  end
end
