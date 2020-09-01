defmodule QaDashboard.Repo do
  use Ecto.Repo,
    otp_app: :qa_dashboard,
    adapter: Ecto.Adapters.Postgres
end
