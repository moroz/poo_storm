defmodule PooStormWeb.MarkdownHelpers do
  def render_markdown_to_safe_html(md) do
    md
    |> HtmlSanitizeEx.basic_html()
    |> Earmark.as_html!()
  end
end
