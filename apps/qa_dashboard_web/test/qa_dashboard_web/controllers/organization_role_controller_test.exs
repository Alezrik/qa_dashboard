defmodule QaDashboardWeb.OrganizationRoleControllerTest do
  use QaDashboardWeb.ConnCase

  alias QaDashboard.Permissions

  @create_attrs %{name: "some name"}
  @update_attrs %{name: "some updated name"}
  @invalid_attrs %{name: nil}

  setup :register_and_log_in_user

  def fixture(:organization_role) do
    {:ok, organization_role} = Permissions.create_organization_role(@create_attrs)
    organization_role
  end

  describe "index" do
    test "lists all organization_roles", %{conn: conn} do
      conn = get(conn, Routes.organization_role_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Organization roles"
    end
  end

  describe "new organization_role" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.organization_role_path(conn, :new))
      assert html_response(conn, 200) =~ "New Organization role"
    end
  end

  describe "create organization_role" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn =
        post(conn, Routes.organization_role_path(conn, :create), organization_role: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.organization_role_path(conn, :show, id)

      conn = get(conn, Routes.organization_role_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Organization role"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn =
        post(conn, Routes.organization_role_path(conn, :create), organization_role: @invalid_attrs)

      assert html_response(conn, 200) =~ "New Organization role"
    end
  end

  describe "edit organization_role" do
    setup [:create_organization_role]

    test "renders form for editing chosen organization_role", %{
      conn: conn,
      organization_role: organization_role
    } do
      conn = get(conn, Routes.organization_role_path(conn, :edit, organization_role))
      assert html_response(conn, 200) =~ "Edit Organization role"
    end
  end

  describe "update organization_role" do
    setup [:create_organization_role]

    test "redirects when data is valid", %{conn: conn, organization_role: organization_role} do
      conn =
        put(conn, Routes.organization_role_path(conn, :update, organization_role),
          organization_role: @update_attrs
        )

      assert redirected_to(conn) == Routes.organization_role_path(conn, :show, organization_role)

      conn = get(conn, Routes.organization_role_path(conn, :show, organization_role))
      assert html_response(conn, 200) =~ "some updated name"
    end

    test "renders errors when data is invalid", %{
      conn: conn,
      organization_role: organization_role
    } do
      conn =
        put(conn, Routes.organization_role_path(conn, :update, organization_role),
          organization_role: @invalid_attrs
        )

      assert html_response(conn, 200) =~ "Edit Organization role"
    end
  end

  describe "delete organization_role" do
    setup [:create_organization_role]

    test "deletes chosen organization_role", %{conn: conn, organization_role: organization_role} do
      conn = delete(conn, Routes.organization_role_path(conn, :delete, organization_role))
      assert redirected_to(conn) == Routes.organization_role_path(conn, :index)

      assert_error_sent 404, fn ->
        get(conn, Routes.organization_role_path(conn, :show, organization_role))
      end
    end
  end

  defp create_organization_role(_) do
    organization_role = fixture(:organization_role)
    %{organization_role: organization_role}
  end
end
