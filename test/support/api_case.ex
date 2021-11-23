defmodule PooStormWeb.ApiCase do
  use ExUnit.CaseTemplate

  using(opts) do
    schema = Keyword.get(opts, :schema, PooStormWeb.Api.Schema)
    api_path = Keyword.get(opts, :api_path, "/api")

    quote do
      @__schema__ unquote(schema)
      @__api_path__ unquote(api_path)
      @endpoint PooStormWeb.Endpoint

      alias PooStorm.Repo

      use ExUnit.Case

      import Ecto
      import Ecto.Changeset
      import Ecto.Query
      import PooStormWeb.ConnCase
      import PooStorm.DataCase
      import PooStorm.Factory
      import PooStormWeb.ApiCase
      import Phoenix.ConnTest

      def run_query(document, variables, context \\ %{}) do
        opts = [variables: normalize_variables(variables), context: context]

        with %{data: data} <- Absinthe.run!(document, @__schema__, opts) do
          data
        else
          error -> {:error, error}
        end
      end

      def query(document, variables) do
        run_query(document, variables)
      end

      def mutate(document, variables) do
        run_query(document, variables)
      end

      def query(document, user, variables) do
        query_with_user(document, user, variables)
      end

      def query_with_user(document, user, variables) do
        run_query(document, variables, %{current_user: user})
      end

      def mutate_with_user(document, user, variables) do
        query_with_user(document, user, variables)
      end

      def query_over_router(conn, query, variables \\ %{}) do
        conn
        |> Plug.Conn.put_req_header("content-type", "application/json")
        |> post(@__api_path__, Jason.encode!(%{query: query, variables: variables}))
      end

      setup tags do
        :ok = Ecto.Adapters.SQL.Sandbox.checkout(PooStorm.Repo)

        Absinthe.Test.prime(@__schema__)

        unless tags[:async] do
          Ecto.Adapters.SQL.Sandbox.mode(PooStorm.Repo, {:shared, self()})
        end

        [conn: Phoenix.ConnTest.build_conn()]
      end
    end
  end

  def normalize_variables([]), do: []

  def normalize_variables([id | _tail] = list) when is_binary(id) or is_integer(id), do: list

  def normalize_variables([head | _tail] = list) when is_map(head) do
    Enum.map(list, &normalize_variables/1)
  end

  def normalize_variables(variables) when is_map(variables) or is_list(variables) do
    Map.new(variables, fn {key, val} -> {camelize_key(key), normalize_variables(val)} end)
  end

  def normalize_variables(atom) when is_atom(atom) and atom not in [true, false, nil],
    do: to_string(atom) |> String.upcase()

  def normalize_variables(other), do: other

  def camelize_key(key) do
    to_string(key)
    |> Absinthe.Utils.camelize(lower: true)
  end

  def get_ids(actual) do
    Enum.map(actual, fn
      %{"id" => id} when is_binary(id) -> String.to_integer(id)
      %{id: id} when is_integer(id) -> id
    end)
    |> Enum.sort()
  end
end
