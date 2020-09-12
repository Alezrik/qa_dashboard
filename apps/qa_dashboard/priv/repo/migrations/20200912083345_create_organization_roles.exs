defmodule QaDashboard.Repo.Migrations.CreateOrganizationRoles do
  use Ecto.Migration

  def change do
    create table(:organization_roles) do
      add :name, :string

      timestamps()
    end

    alter table(:organization_user_roles) do
      add :organization_role_id, references(:organization_roles, on_delete: :nothing)
    end

    create index(:organization_user_roles, [:organization_role_id])
  end
end
