defmodule QaDashboard.Permissions.Role do
  @moduledoc """
  role for permission groupings

  """
  use Ecto.Schema
  import Ecto.Changeset

  schema "roles" do
    field :name, :string
    has_many :user_id, QaDashboard.Permissions.OrganizationUserRole

    timestamps()
  end

  @doc false
  def changeset(role, attrs) do
    role
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
