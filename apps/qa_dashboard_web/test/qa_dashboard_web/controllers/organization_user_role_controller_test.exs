defmodule QaDashboardWeb.OrganizationUserRoleControllerTest do
  use QaDashboardWeb.ConnCase

  alias QaDashboard.Permissions

  setup :register_and_log_in_user

  @create_attrs %{}
  @update_attrs %{}
  @invalid_attrs %{}

  def fixture(:organization_user_role) do
    {:ok, organization_user_role} = Permissions.create_organization_user_role(@create_attrs)
    organization_user_role
  end

  describe "index" do
    test "lists all organization_user_roles", %{conn: conn} do
      conn = get(conn, Routes.organization_user_role_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Organization user roles"
    end
  end

  describe "new organization_user_role" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.organization_user_role_path(conn, :new))
      assert html_response(conn, 200) =~ "New Organization user role"
    end
  end

  describe "create organization_user_role" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn =
        post(conn, Routes.organization_user_role_path(conn, :create),
          organization_user_role: @create_attrs
        )

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.organization_user_role_path(conn, :show, id)

      conn = get(conn, Routes.organization_user_role_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Organization user role"
    end

    #    test "renders errors when data is invalid", %{conn: conn} do
    #      conn = post(conn, Routes.organization_user_role_path(conn, :create), organization_user_role: @invalid_attrs)
    #      assert html_response(conn, 200) =~ "New Organization user role"
    #    end
  end

  describe "edit organization_user_role" do
    setup [:create_organization_user_role]

    test "renders form for editing chosen organization_user_role", %{
      conn: conn,
      organization_user_role: organization_user_role
    } do
      conn = get(conn, Routes.organization_user_role_path(conn, :edit, organization_user_role))
      assert html_response(conn, 200) =~ "Edit Organization user role"
    end
  end

  describe "update organization_user_role" do
    setup [:create_organization_user_role]

    test "redirects when data is valid", %{
      conn: conn,
      organization_user_role: organization_user_role
    } do
      conn =
        put(conn, Routes.organization_user_role_path(conn, :update, organization_user_role),
          organization_user_role: @update_attrs
        )

      assert redirected_to(conn) ==
               Routes.organization_user_role_path(conn, :show, organization_user_role)

      conn = get(conn, Routes.organization_user_role_path(conn, :show, organization_user_role))
      assert html_response(conn, 200)
    end

    #    test "renders errors when data is invalid", %{conn: conn, organization_user_role: organization_user_role} do
    #      conn = put(conn, Routes.organization_user_role_path(conn, :update, organization_user_role), organization_user_role: @invalid_attrs)
    #      assert html_response(conn, 200) =~ "Edit Organization user role"
    #    end
  end

  describe "delete organization_user_role" do
    setup [:create_organization_user_role]

    test "deletes chosen organization_user_role", %{
      conn: conn,
      organization_user_role: organization_user_role
    } do
      conn =
        delete(conn, Routes.organization_user_role_path(conn, :delete, organization_user_role))

      assert redirected_to(conn) == Routes.organization_user_role_path(conn, :index)

      assert_error_sent 404, fn ->
        get(conn, Routes.organization_user_role_path(conn, :show, organization_user_role))
      end
    end
  end

  defp create_organization_user_role(_) do
    organization_user_role = fixture(:organization_user_role)
    %{organization_user_role: organization_user_role}
  end
end
