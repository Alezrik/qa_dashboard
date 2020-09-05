defmodule QaDashboard.Organizations.Organization do
  @moduledoc """
  your basic organization
  """
  use Ecto.Schema
  import Ecto.Changeset

  schema "organizations" do
    field :name, :string
    has_many :organization_user_roles, QaDashboard.Permissions.OrganizationUserRole
    timestamps()
  end

  @doc false
  def changeset(organization, attrs) do
    organization
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
