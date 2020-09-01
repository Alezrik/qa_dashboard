defmodule QaDashboardWeb.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      QaDashboardWeb.Telemetry,
      # Start the Endpoint (http/https)
      QaDashboardWeb.Endpoint
      # Start a worker by calling: QaDashboardWeb.Worker.start_link(arg)
      # {QaDashboardWeb.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: QaDashboardWeb.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    QaDashboardWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
