defmodule QaDashboard.Permissions.OrganizationRole do
  @moduledoc """
  role that a user will have in an organization
  """
  use Ecto.Schema
  import Ecto.Changeset

  schema "organization_roles" do
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(organization_role, attrs) do
    organization_role
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
