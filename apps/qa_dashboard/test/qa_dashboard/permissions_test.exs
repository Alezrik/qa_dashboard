defmodule QaDashboard.PermissionsTest do
  use QaDashboard.DataCase

  alias QaDashboard.Permissions

  describe "roles" do
    alias QaDashboard.Permissions.Role

    @valid_attrs %{name: "some name"}
    @update_attrs %{name: "some updated name"}
    @invalid_attrs %{name: nil}

    def role_fixture(attrs \\ %{}) do
      {:ok, role} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Permissions.create_role()

      role
    end

    test "list_roles/0 returns all roles" do
      role = role_fixture()
      assert Permissions.list_roles() == [role]
    end

    test "get_role!/1 returns the role with given id" do
      role = role_fixture()
      assert Permissions.get_role!(role.id) == role
    end

    test "create_role/1 with valid data creates a role" do
      assert {:ok, %Role{} = role} = Permissions.create_role(@valid_attrs)
      assert role.name == "some name"
    end

    #    test "create_role/1 with invalid data returns error changeset" do
    #      assert {:error, %Ecto.Changeset{}} = Permissions.create_role(@invalid_attrs)
    #    end

    test "update_role/2 with valid data updates the role" do
      role = role_fixture()
      assert {:ok, %Role{} = role} = Permissions.update_role(role, @update_attrs)
      assert role.name == "some updated name"
    end

    #    test "update_role/2 with invalid data returns error changeset" do
    #      role = role_fixture()
    #      assert {:error, %Ecto.Changeset{}} = Permissions.update_role(role, @invalid_attrs)
    #      assert role == Permissions.get_role!(role.id)
    #    end

    test "delete_role/1 deletes the role" do
      role = role_fixture()
      assert {:ok, %Role{}} = Permissions.delete_role(role)
      assert_raise Ecto.NoResultsError, fn -> Permissions.get_role!(role.id) end
    end

    test "change_role/1 returns a role changeset" do
      role = role_fixture()
      assert %Ecto.Changeset{} = Permissions.change_role(role)
    end
  end

  describe "organization_user_roles" do
    alias QaDashboard.Permissions.OrganizationUserRole

    @valid_attrs %{}
    @update_attrs %{}
    @invalid_attrs %{}

    def organization_user_role_fixture(attrs \\ %{}) do
      {:ok, organization_user_role} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Permissions.create_organization_user_role()

      organization_user_role
    end

    test "list_organization_user_roles/0 returns all organization_user_roles" do
      organization_user_role = organization_user_role_fixture()
      assert Permissions.list_organization_user_roles() == [organization_user_role]
    end

    test "get_organization_user_role!/1 returns the organization_user_role with given id" do
      organization_user_role = organization_user_role_fixture()

      assert Permissions.get_organization_user_role!(organization_user_role.id) ==
               organization_user_role
    end

    test "create_organization_user_role/1 with valid data creates a organization_user_role" do
      assert {:ok, %OrganizationUserRole{} = organization_user_role} =
               Permissions.create_organization_user_role(@valid_attrs)
    end

    #    test "create_organization_user_role/1 with invalid data returns error changeset" do
    #      assert {:error, %Ecto.Changeset{}} =
    #               Permissions.create_organization_user_role(@invalid_attrs)
    #    end

    test "update_organization_user_role/2 with valid data updates the organization_user_role" do
      organization_user_role = organization_user_role_fixture()

      assert {:ok, %OrganizationUserRole{} = organization_user_role} =
               Permissions.update_organization_user_role(organization_user_role, @update_attrs)
    end

    #    test "update_organization_user_role/2 with invalid data returns error changeset" do
    #      organization_user_role = organization_user_role_fixture()
    #
    #      assert {:error, %Ecto.Changeset{}} =
    #               Permissions.update_organization_user_role(organization_user_role, @invalid_attrs)
    #
    #      assert organization_user_role ==
    #               Permissions.get_organization_user_role!(organization_user_role.id)
    #    end

    test "delete_organization_user_role/1 deletes the organization_user_role" do
      organization_user_role = organization_user_role_fixture()

      assert {:ok, %OrganizationUserRole{}} =
               Permissions.delete_organization_user_role(organization_user_role)

      assert_raise Ecto.NoResultsError, fn ->
        Permissions.get_organization_user_role!(organization_user_role.id)
      end
    end

    test "change_organization_user_role/1 returns a organization_user_role changeset" do
      organization_user_role = organization_user_role_fixture()
      assert %Ecto.Changeset{} = Permissions.change_organization_user_role(organization_user_role)
    end
  end
end
