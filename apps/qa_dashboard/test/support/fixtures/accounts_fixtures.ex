defmodule QaDashboard.AccountsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `QaDashboard.Accounts` context.
  """
  require Logger

  def unique_user_email, do: "user#{System.unique_integer()}@example.com"
  def valid_user_password, do: "hello world!"

  def user_fixture(attrs \\ %{}) do
    role = setup_roles()

    {:ok, user} =
      attrs
      |> Enum.into(%{
        email: unique_user_email(),
        password: valid_user_password(),
        role_id: role.id
      })
      |> QaDashboard.Accounts.register_user()

    user
  end

  def extract_user_token(fun) do
    {:ok, captured} = fun.(&"[TOKEN]#{&1}[TOKEN]")
    [_, token, _] = String.split(captured.body, "[TOKEN]")
    token
  end

  def setup_roles() do
    roles = QaDashboard.Permissions.list_roles()

    if Enum.empty?(roles) do
      {:ok, _role} = QaDashboard.Permissions.create_role(%{name: "superAdmin"})
      {:ok, role} = QaDashboard.Permissions.create_role(%{name: "user"})
      role
    else
      List.first(Enum.filter(roles, fn x -> x.name == "user" end))
    end
  end
end
