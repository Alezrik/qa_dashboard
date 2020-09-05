defmodule QaDashboardWeb.RoleController do
  use QaDashboardWeb, :controller
  import Canada, only: [can?: 2]

  alias QaDashboard.Permissions
  alias QaDashboard.Permissions.Role
  alias QaDashboardWeb.AuthorizationError

  @object_name "role"

  def index(conn, _params) do
    user = conn.assigns[:current_user]

    if user |> can?(index(@object_name)) do
      roles = Permissions.list_roles()
      render(conn, "index.html", roles: roles)
    else
      AuthorizationError.handle_authorization_error(conn, "index", @object_name)
    end
  end

  def new(conn, _params) do
    user = conn.assigns[:current_user]

    if user |> can?(new(@object_name)) do
      changeset = Permissions.change_role(%Role{})
      render(conn, "new.html", changeset: changeset)
    else
      AuthorizationError.handle_authorization_error(conn, "new", @object_name)
    end
  end

  def create(conn, %{"role" => role_params}) do
    user = conn.assigns[:current_user]

    if user |> can?(create(@object_name)) do
      case Permissions.create_role(role_params) do
        {:ok, role} ->
          conn
          |> put_flash(:info, "Role created successfully.")
          |> redirect(to: Routes.role_path(conn, :show, role))

        {:error, %Ecto.Changeset{} = changeset} ->
          render(conn, "new.html", changeset: changeset)
      end
    else
      AuthorizationError.handle_authorization_error(conn, "create", @object_name)
    end
  end

  def show(conn, %{"id" => id}) do
    user = conn.assigns[:current_user]

    if user |> can?(show(@object_name)) do
      role = Permissions.get_role!(id)
      render(conn, "show.html", role: role)
    else
      AuthorizationError.handle_authorization_error(conn, "show", @object_name)
    end
  end

  def edit(conn, %{"id" => id}) do
    user = conn.assigns[:current_user]

    if user |> can?(edit(@object_name)) do
      role = Permissions.get_role!(id)
      changeset = Permissions.change_role(role)
      render(conn, "edit.html", role: role, changeset: changeset)
    else
      AuthorizationError.handle_authorization_error(conn, "edit", @object_name)
    end
  end

  def update(conn, %{"id" => id, "role" => role_params}) do
    user = conn.assigns[:current_user]

    if user |> can?(edit(@object_name)) do
      role = Permissions.get_role!(id)

      case Permissions.update_role(role, role_params) do
        {:ok, role} ->
          conn
          |> put_flash(:info, "Role updated successfully.")
          |> redirect(to: Routes.role_path(conn, :show, role))

        {:error, %Ecto.Changeset{} = changeset} ->
          render(conn, "edit.html", role: role, changeset: changeset)
      end
    else
      AuthorizationError.handle_authorization_error(conn, "edit", @object_name)
    end
  end

  def delete(conn, %{"id" => id}) do
    user = conn.assigns[:current_user]

    if user |> can?(delete(@object_name)) do
      role = Permissions.get_role!(id)
      {:ok, _role} = Permissions.delete_role(role)

      conn
      |> put_flash(:info, "Role deleted successfully.")
      |> redirect(to: Routes.role_path(conn, :index))
    else
      AuthorizationError.handle_authorization_error(conn, "delete", @object_name)
    end
  end
end
