defmodule PooStormWeb.Api.Middleware.TransformErrors do
  @behaviour Absinthe.Middleware

  import Absinthe.Utils
  alias PooStormWeb.ErrorHelpers

  def call(res, _) do
    with %{errors: [error]} <- res do
      %{res | errors: [], value: handle_error(error)}
    end
  end

  def handle_error(%Ecto.Changeset{} = changeset) do
    %{success: false, errors: transform_errors(changeset)}
  end

  def handle_error(message) when is_binary(message) do
    %{success: false, errors: %{"message" => message}}
  end

  def handle_error(errors) when is_map(errors) do
    %{success: false, errors: errors}
  end

  defp transform_errors(changeset) do
    Ecto.Changeset.traverse_errors(changeset, &ErrorHelpers.translate_error/1)
    |> normalize_map()
  end

  defp normalize_map(map) do
    Map.new(map, fn {key, value} -> {format_key(key), value} end)
  end

  defp format_key(key) do
    key
    |> to_string
    |> camelize(lower: true)
  end
end
