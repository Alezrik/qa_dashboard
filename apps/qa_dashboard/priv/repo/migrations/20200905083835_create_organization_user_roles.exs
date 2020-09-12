defmodule QaDashboard.Repo.Migrations.CreateOrganizationUserRoles do
  use Ecto.Migration

  def change do
    create table(:organization_user_roles) do
      add :user_id, references(:users, on_delete: :nothing)
      add :organization_id, references(:organizations, on_delete: :nothing)

      timestamps()
    end

    create index(:organization_user_roles, [:user_id])
    create index(:organization_user_roles, [:organization_id])
  end
end
