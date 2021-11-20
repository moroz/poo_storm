defmodule PooStormWeb.Api.Types.Comments do
  use Absinthe.Schema.Notation
  alias PooStormWeb.Api.CommentResolvers

  object :comment do
    field :id, non_null(:id)
    field :body, non_null(:string)
    field :signature, non_null(:string)
    field :remote_ip, :string
    field :inserted_at, non_null(:datetime)
    field :updated_at, non_null(:datetime)
  end

  object :comment_queries do
    field :list_comments, non_null(list_of(non_null(:comment))) do
      arg(:path, non_null(:string))
      resolve(&CommentResolvers.list_comments/2)
    end
  end
end
