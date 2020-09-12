defmodule QaDashboard.AccountsOrganizationsTest do
  use QaDashboard.DataCase

  alias QaDashboard.Accounts
  import QaDashboard.AccountsFixtures
  alias QaDashboard.Accounts.{User, UserToken}
  alias QaDashboard.Organizations
  alias QaDashboard.Permissions

  require Logger

  describe("accounts and organizations have links") do
    alias QaDashboard.Organizations.Organization
    alias QaDashboard.Permissions.Role

    @role_data %{name: "some#{System.unique_integer()}name"}

    def role_fixture(attrs \\ %{}) do
      {:ok, role} =
        attrs
        |> Enum.into(@role_data)
        |> Permissions.create_organization_role()

      role
    end

    @organization_create %{name: "some#{System.unique_integer()}name"}

    def organization_fixture(attrs \\ %{}) do
      {:ok, organization} =
        attrs
        |> Enum.into(@organization_create)
        |> Organizations.create_organization()

      organization
    end
  end

  test "link a user to an account" do
    user = user_fixture(%{email: unique_user_email(), password: valid_user_password()})
    organization = organization_fixture(@organization_create)
    role = role_fixture(@role_data)

    user_organization_role =
      QaDashboard.Permissions.OrganizationUserRole.link_user_organization_changeset(
        %QaDashboard.Permissions.OrganizationUserRole{},
        %{
          user_id: user.id,
          organization_id: organization.id,
          organization_role_id: role.id
        }
      )

    QaDashboard.Repo.insert(user_organization_role)
    user = Accounts.user_load_organization_roles(user)

    assert Enum.count(user.organization_user_role_ids) == 1
  end
end
