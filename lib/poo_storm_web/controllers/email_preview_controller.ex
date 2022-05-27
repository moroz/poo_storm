defmodule PooStormWeb.EmailPreviewController do
  use PooStormWeb, :controller
  plug :put_layout, {PooStormWeb.LayoutView, :email}

  def new_comment(conn, _params) do
    comment = PooStorm.Comments.get_last_comment()
    render(conn, "new_comment.html", comment: comment)
  end
end
