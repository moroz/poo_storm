defmodule PooStormWeb.Api.Types.Comments do
  use Absinthe.Schema.Notation

  object :comment do
    field :id, non_null(:id)
    field :body, non_null(:string)
    field :signature, non_null(:string)
    field :remote_ip, :string
    field :inserted_at, non_null(:datetime)
    field :updated_at, non_null(:datetime)
  end
end
