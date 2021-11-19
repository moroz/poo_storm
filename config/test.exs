import Config

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :poo_storm, PooStorm.Repo,
  username: "postgres",
  password: "postgres",
  database: "poo_storm_test#{System.get_env("MIX_TEST_PARTITION")}",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox,
  pool_size: 10

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :poo_storm, PooStormWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "kNjio6bjhj12BKq1yV7J3JVM/IU/zab9qrpd5HlZgPBdzT6Yb0+2nAd6UX+5+bQX",
  server: false

# In test we don't send emails.
config :poo_storm, PooStorm.Mailer, adapter: Swoosh.Adapters.Test

# Print only warnings and errors during test
config :logger, level: :warn

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
