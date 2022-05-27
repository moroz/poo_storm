# This file is responsible for configuring your application
# and its dependencies with the aid of the Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

config :poo_storm,
  ecto_repos: [PooStorm.Repo]

# Configures the endpoint
config :poo_storm, PooStormWeb.Endpoint,
  url: [host: "localhost"],
  render_errors: [view: PooStormWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: PooStorm.PubSub,
  live_view: [signing_salt: "DkNmW1na"]

# Configures the mailer
#
# By default it uses the "Local" adapter which stores the emails
# locally. You can see the emails in your browser, at "/dev/mailbox".
#
# For production it's recommended to configure a different adapter
# at the `config/runtime.exs`.
config :poo_storm, PooStorm.Mailer, adapter: Swoosh.Adapters.Local

# Swoosh API client is needed for adapters other than SMTP.
config :swoosh, :api_client, false

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :poo_storm, PooStorm.Mailer,
  sender: {System.get_env("MAILER_SENDER_NAME"), System.get_env("MAILER_USERNAME")},
  recipient: {System.get_env("MAILER_RECIPIENT_NAME"), System.get_env("MAILER_RECIPIENT_EMAIL")},
  website_url: System.get_env("WEBSITE_PUBLIC_URL")

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"
