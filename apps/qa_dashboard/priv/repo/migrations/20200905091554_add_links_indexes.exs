defmodule QaDashboard.Repo.Migrations.AddLinksIndexes do
  use Ecto.Migration

  def change do
    create unique_index("organization_user_roles", [:user_id, :organization_id])
    create unique_index("roles", [:name])
    create unique_index("organizations", [:name])
  end
end
