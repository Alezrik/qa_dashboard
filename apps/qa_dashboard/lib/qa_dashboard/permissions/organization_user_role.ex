defmodule QaDashboard.Permissions.OrganizationUserRole do
  use Ecto.Schema
  import Ecto.Changeset

  schema "organization_user_roles" do
    field :user_id, :id
    field :organization_id, :id
    field :role_id, :id

    timestamps()
  end

  @doc false
  def changeset(organization_user_role, attrs) do
    organization_user_role
    |> cast(attrs, [])
    |> validate_required([])
  end
end
