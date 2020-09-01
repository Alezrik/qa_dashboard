defmodule QaDashboard.Repo.Migrations.CreateUserIngestTokens do
  use Ecto.Migration

  def change do
    create table(:user_ingest_tokens) do
      add :token, :binary
      add :name, :string
      add :type, :string
      add :user_id, references(:users, on_delete: :nothing)

      timestamps()
    end

    create index(:user_ingest_tokens, [:user_id])
  end
end
