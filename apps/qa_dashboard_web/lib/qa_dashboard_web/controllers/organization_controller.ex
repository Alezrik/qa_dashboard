defmodule QaDashboardWeb.OrganizationController do
  use QaDashboardWeb, :controller
  alias QaDashboardWeb.AuthorizationError

  import Canada, only: [can?: 2]

  alias QaDashboard.Organizations
  alias QaDashboard.Organizations.Organization

  @object_name "organizations"

  def index(conn, _params) do
    user = conn.assigns[:current_user]

    if user |> can?(index(@object_name)) do
      organizations = Organizations.list_organizations()
      render(conn, "index.html", organizations: organizations)
    else
      AuthorizationError.handle_authorization_error(conn, "index", @object_name)
    end
  end

  def new(conn, _params) do
    user = conn.assigns[:current_user]

    if user |> can?(new(@object_name)) do
      changeset = Organizations.change_organization(%Organization{})
      render(conn, "new.html", changeset: changeset)
    else
      AuthorizationError.handle_authorization_error(conn, "new", @object_name)
    end
  end

  def create(conn, %{"organization" => organization_params}) do
    user = conn.assigns[:current_user]

    if user |> can?(create(@object_name)) do
      case Organizations.create_organization(organization_params) do
        {:ok, organization} ->
          conn
          |> put_flash(:info, "Organization created successfully.")
          |> redirect(to: Routes.organization_path(conn, :show, organization))

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
      organization = Organizations.get_organization!(id)
      render(conn, "show.html", organization: organization)
    else
      AuthorizationError.handle_authorization_error(conn, "show", @object_name)
    end
  end

  def edit(conn, %{"id" => id}) do
    user = conn.assigns[:current_user]

    if user |> can?(edit(@object_name)) do
      organization = Organizations.get_organization!(id)
      changeset = Organizations.change_organization(organization)
      render(conn, "edit.html", organization: organization, changeset: changeset)
    else
      AuthorizationError.handle_authorization_error(conn, "edit", @object_name)
    end
  end

  def update(conn, %{"id" => id, "organization" => organization_params}) do
    user = conn.assigns[:current_user]

    if user |> can?(update(@object_name)) do
      organization = Organizations.get_organization!(id)

      case Organizations.update_organization(organization, organization_params) do
        {:ok, organization} ->
          conn
          |> put_flash(:info, "Organization updated successfully.")
          |> redirect(to: Routes.organization_path(conn, :show, organization))

        {:error, %Ecto.Changeset{} = changeset} ->
          render(conn, "edit.html", organization: organization, changeset: changeset)
      end
    else
      AuthorizationError.handle_authorization_error(conn, "update", @object_name)
    end
  end

  def delete(conn, %{"id" => id}) do
    user = conn.assigns[:current_user]

    if user |> can?(delete(@object_name)) do
      organization = Organizations.get_organization!(id)
      {:ok, _organization} = Organizations.delete_organization(organization)

      conn
      |> put_flash(:info, "Organization deleted successfully.")
      |> redirect(to: Routes.organization_path(conn, :index))
    else
      AuthorizationError.handle_authorization_error(conn, "delete", @object_name)
    end
  end
end
