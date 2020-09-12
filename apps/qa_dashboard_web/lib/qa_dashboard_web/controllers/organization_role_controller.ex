defmodule QaDashboardWeb.OrganizationRoleController do
  use QaDashboardWeb, :controller

  alias QaDashboard.Permissions
  alias QaDashboard.Permissions.OrganizationRole

  def index(conn, _params) do
    organization_roles = Permissions.list_organization_roles()
    render(conn, "index.html", organization_roles: organization_roles)
  end

  def new(conn, _params) do
    changeset = Permissions.change_organization_role(%OrganizationRole{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"organization_role" => organization_role_params}) do
    case Permissions.create_organization_role(organization_role_params) do
      {:ok, organization_role} ->
        conn
        |> put_flash(:info, "Organization role created successfully.")
        |> redirect(to: Routes.organization_role_path(conn, :show, organization_role))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    organization_role = Permissions.get_organization_role!(id)
    render(conn, "show.html", organization_role: organization_role)
  end

  def edit(conn, %{"id" => id}) do
    organization_role = Permissions.get_organization_role!(id)
    changeset = Permissions.change_organization_role(organization_role)
    render(conn, "edit.html", organization_role: organization_role, changeset: changeset)
  end

  def update(conn, %{"id" => id, "organization_role" => organization_role_params}) do
    organization_role = Permissions.get_organization_role!(id)

    case Permissions.update_organization_role(organization_role, organization_role_params) do
      {:ok, organization_role} ->
        conn
        |> put_flash(:info, "Organization role updated successfully.")
        |> redirect(to: Routes.organization_role_path(conn, :show, organization_role))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", organization_role: organization_role, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    organization_role = Permissions.get_organization_role!(id)
    {:ok, _organization_role} = Permissions.delete_organization_role(organization_role)

    conn
    |> put_flash(:info, "Organization role deleted successfully.")
    |> redirect(to: Routes.organization_role_path(conn, :index))
  end
end
