defmodule PooStormWeb.EmailPreviewController do
  use PooStormWeb, :controller
  plug :put_layout, {PooStormWeb.LayoutView, :email}

  def new_comment(conn, _params) do
    comment = PooStorm.Comments.get_last_comment()
    email = PooStorm.CommentEmail.new_comment(comment)

    conn
    |> put_resp_content_type("text/html")
    |> send_resp(200, email.html_body)
  end
end
