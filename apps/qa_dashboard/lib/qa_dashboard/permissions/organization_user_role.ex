defmodule QaDashboard.Permissions.OrganizationUserRole do
  @moduledoc """
  a link between a user an organization and a role
  """
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

  def link_user_organization_changeset(organization_user_role, attrs) do
    organization_user_role
    |> cast(attrs, [:user_id, :organization_id, :role_id])
    |> validate_required([:user_id, :organization_id, :role_id])
  end
end
