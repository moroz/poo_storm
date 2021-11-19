defmodule PooStorm.Repo do
  use Ecto.Repo,
    otp_app: :poo_storm,
    adapter: Ecto.Adapters.Postgres
end
