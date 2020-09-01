defmodule QaDashboard.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      QaDashboard.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: QaDashboard.PubSub}
      # Start a worker by calling: QaDashboard.Worker.start_link(arg)
      # {QaDashboard.Worker, arg}
    ]

    Supervisor.start_link(children, strategy: :one_for_one, name: QaDashboard.Supervisor)
  end
end
