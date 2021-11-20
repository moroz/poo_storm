defmodule PooStormWeb.Api.Schema do
  use Absinthe.Schema

  import_types(Absinthe.Type.Custom)
  import_types(PooStormWeb.Api.Types.Comments)

  query do
    import_fields(:comment_queries)
  end
end
