defmodule PooStormWeb.Api.Schema do
  use Absinthe.Schema

  import_types(Absinthe.Type.Custom)
  import_types(PooStormWeb.Api.Types.Comments)
  import_types(PooStormWeb.Api.Types.JSON)

  query do
    import_fields(:comment_queries)
  end

  mutation do
    import_fields(:comment_mutations)
  end
end
