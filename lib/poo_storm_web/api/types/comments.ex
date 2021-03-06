defmodule PooStormWeb.Api.Types.Comments do
  use Absinthe.Schema.Notation
  alias PooStormWeb.Api.CommentResolvers

  enum :body_format do
    value(:raw)
    value(:markdown)
  end

  object :comment do
    field :id, non_null(:id)

    field :body, non_null(:string) do
      arg(:format, non_null(:body_format), default_value: :markdown)
      resolve(&CommentResolvers.resolve_body/3)
    end

    field :signature, non_null(:string)
    field :url, non_null(:string)
    field :remote_ip, :string
    field :inserted_at, non_null(:datetime)
    field :updated_at, non_null(:datetime)
    field :website, :string
  end

  input_object :comment_input do
    field :body, non_null(:string)
    field :signature, non_null(:string)
    field :url, non_null(:string)
    field :email, non_null(:string)
    field :website, :string
    field :i_am_a_robot, :boolean
  end

  object :comment_mutation_result do
    field :success, non_null(:boolean)
    field :errors, :json
    field :data, :comment
  end

  object :comment_queries do
    field :list_comments, non_null(list_of(non_null(:comment))) do
      arg(:url, non_null(:string))
      resolve(&CommentResolvers.list_comments/2)
    end
  end

  object :comment_mutations do
    field :create_comment, non_null(:comment_mutation_result) do
      arg(:input, non_null(:comment_input))
      resolve(&CommentResolvers.create_comment/2)
      middleware(PooStormWeb.Api.Middleware.TransformErrors)
    end
  end
end
