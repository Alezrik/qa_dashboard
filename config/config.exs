# This file is responsible for configuring your umbrella
# and **all applications** and their dependencies with the
# help of Mix.Config.
#
# Note that all applications in your umbrella share the
# same configuration and dependencies, which is why they
# all use the same configuration file. If you want different
# configurations or dependencies per app, it is best to
# move said applications out of the umbrella.
use Mix.Config

# Configure Mix tasks and generators
config :qa_dashboard,
  ecto_repos: [QaDashboard.Repo]

config :qa_dashboard_web,
  ecto_repos: [QaDashboard.Repo],
  generators: [context_app: :qa_dashboard]

# Configures the endpoint
config :qa_dashboard_web, QaDashboardWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "ymI65Nh8k99mu3VtHTIrT37hJzmQG6oa4AV2KSYbPgw/GrRMeJCfkr8ESsPXUJu3",
  render_errors: [view: QaDashboardWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: QaDashboard.PubSub,
  live_view: [signing_salt: "Y2IVO0VW"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
