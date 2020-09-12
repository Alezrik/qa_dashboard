defmodule QaDashboardWeb.OrganizationUserRoleController do
  use QaDashboardWeb, :controller
  import Canada, only: [can?: 2]
  alias QaDashboardWeb.AuthorizationError

  alias QaDashboard.Permissions
  alias QaDashboard.Permissions.OrganizationUserRole

  @object_name "organization_user_role"

  def index(conn, _params) do
    organization_user_roles = Permissions.list_organization_user_roles()
    render(conn, "index.html", organization_user_roles: organization_user_roles)
  end

  def new(conn, _params) do
    changeset = Permissions.change_organization_user_role(%OrganizationUserRole{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"organization_user_role" => organization_user_role_params}) do
    case Permissions.create_organization_user_role(organization_user_role_params) do
      {:ok, organization_user_role} ->
        conn
        |> put_flash(:info, "Organization user role created successfully.")
        |> redirect(to: Routes.organization_user_role_path(conn, :show, organization_user_role))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    organization_user_role = Permissions.get_organization_user_role!(id)
    render(conn, "show.html", organization_user_role: organization_user_role)
  end

  def edit(conn, %{"id" => id}) do
    organization_user_role = Permissions.get_organization_user_role!(id)
    changeset = Permissions.change_organization_user_role(organization_user_role)

    render(conn, "edit.html",
      organization_user_role: organization_user_role,
      changeset: changeset
    )
  end

  def update(conn, %{"id" => id, "organization_user_role" => organization_user_role_params}) do
    organization_user_role = Permissions.get_organization_user_role!(id)

    case Permissions.update_organization_user_role(
           organization_user_role,
           organization_user_role_params
         ) do
      {:ok, organization_user_role} ->
        conn
        |> put_flash(:info, "Organization user role updated successfully.")
        |> redirect(to: Routes.organization_user_role_path(conn, :show, organization_user_role))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html",
          organization_user_role: organization_user_role,
          changeset: changeset
        )
    end
  end

  def delete(conn, %{"id" => id}) do
    organization_user_role = Permissions.get_organization_user_role!(id)

    {:ok, _organization_user_role} =
      Permissions.delete_organization_user_role(organization_user_role)

    conn
    |> put_flash(:info, "Organization user role deleted successfully.")
    |> redirect(to: Routes.organization_user_role_path(conn, :index))
  end
end
