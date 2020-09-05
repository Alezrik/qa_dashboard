defmodule QaDashboard.Permissions do
  @moduledoc """
  The Permissions context.
  """

  import Ecto.Query, warn: false
  alias QaDashboard.Repo

  alias QaDashboard.Permissions.Role

  @doc """
  Returns the list of roles.

  ## Examples

      iex> list_roles()
      [%Role{}, ...]

  """
  def list_roles do
    Repo.all(Role)
  end

  @doc """
  Gets a single role.

  Raises `Ecto.NoResultsError` if the Role does not exist.

  ## Examples

      iex> get_role!(123)
      %Role{}

      iex> get_role!(456)
      ** (Ecto.NoResultsError)

  """
  def get_role!(id), do: Repo.get!(Role, id)

  @doc """
  Creates a role.

  ## Examples

      iex> create_role(%{field: value})
      {:ok, %Role{}}

      iex> create_role(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_role(attrs \\ %{}) do
    %Role{}
    |> Role.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a role.

  ## Examples

      iex> update_role(role, %{field: new_value})
      {:ok, %Role{}}

      iex> update_role(role, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_role(%Role{} = role, attrs) do
    role
    |> Role.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a role.

  ## Examples

      iex> delete_role(role)
      {:ok, %Role{}}

      iex> delete_role(role)
      {:error, %Ecto.Changeset{}}

  """
  def delete_role(%Role{} = role) do
    Repo.delete(role)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking role changes.

  ## Examples

      iex> change_role(role)
      %Ecto.Changeset{data: %Role{}}

  """
  def change_role(%Role{} = role, attrs \\ %{}) do
    Role.changeset(role, attrs)
  end

  alias QaDashboard.Permissions.OrganizationUserRole

  @doc """
  Returns the list of organization_user_roles.

  ## Examples

      iex> list_organization_user_roles()
      [%OrganizationUserRole{}, ...]

  """
  def list_organization_user_roles do
    Repo.all(OrganizationUserRole)
  end

  @doc """
  Gets a single organization_user_role.

  Raises `Ecto.NoResultsError` if the Organization user role does not exist.

  ## Examples

      iex> get_organization_user_role!(123)
      %OrganizationUserRole{}

      iex> get_organization_user_role!(456)
      ** (Ecto.NoResultsError)

  """
  def get_organization_user_role!(id), do: Repo.get!(OrganizationUserRole, id)

  @doc """
  Creates a organization_user_role.

  ## Examples

      iex> create_organization_user_role(%{field: value})
      {:ok, %OrganizationUserRole{}}

      iex> create_organization_user_role(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_organization_user_role(attrs \\ %{}) do
    %OrganizationUserRole{}
    |> OrganizationUserRole.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a organization_user_role.

  ## Examples

      iex> update_organization_user_role(organization_user_role, %{field: new_value})
      {:ok, %OrganizationUserRole{}}

      iex> update_organization_user_role(organization_user_role, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_organization_user_role(%OrganizationUserRole{} = organization_user_role, attrs) do
    organization_user_role
    |> OrganizationUserRole.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a organization_user_role.

  ## Examples

      iex> delete_organization_user_role(organization_user_role)
      {:ok, %OrganizationUserRole{}}

      iex> delete_organization_user_role(organization_user_role)
      {:error, %Ecto.Changeset{}}

  """
  def delete_organization_user_role(%OrganizationUserRole{} = organization_user_role) do
    Repo.delete(organization_user_role)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking organization_user_role changes.

  ## Examples

      iex> change_organization_user_role(organization_user_role)
      %Ecto.Changeset{data: %OrganizationUserRole{}}

  """
  def change_organization_user_role(
        %OrganizationUserRole{} = organization_user_role,
        attrs \\ %{}
      ) do
    OrganizationUserRole.changeset(organization_user_role, attrs)
  end
end
