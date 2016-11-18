# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :alenx_blog_engine,
  ecto_repos: [AlenxBlogEngine.Repo]

# Configures the endpoint
config :alenx_blog_engine, AlenxBlogEngine.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "fvQ7RDvqJ0D6ePUCsa7rm3pe3+6xZmU66ZqNhk61pgApFu66q1I/VvMe6vz2GBKN",
  render_errors: [view: AlenxBlogEngine.ErrorView, accepts: ~w(json)],
  pubsub: [name: AlenxBlogEngine.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
