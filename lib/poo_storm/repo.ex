defmodule PooStorm.Repo do
  use Ecto.Repo,
    otp_app: :poo_storm,
    adapter: Ecto.Adapters.Postgres

  def count(queryable) do
    aggregate(queryable, :count)
  end
end
