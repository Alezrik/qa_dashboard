defmodule QaDashboardWeb.UserRegistrationController do
  use QaDashboardWeb, :controller

  alias QaDashboard.Accounts
  alias QaDashboard.Accounts.User
  alias QaDashboardWeb.UserAuth
  require Logger

  def new(conn, _params) do
    changeset = Accounts.change_user_registration(%User{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"user" => user_params}) do
    role = default_registration_role()

    register_user_params = %{
      email: user_params["email"],
      password: user_params["password"],
      role_id: role.id
    }

    case Accounts.register_user(register_user_params) do
      {:ok, user} ->
        {:ok, _} =
          Accounts.deliver_user_confirmation_instructions(
            user,
            &Routes.user_confirmation_url(conn, :confirm, &1)
          )

        conn
        |> put_flash(:info, "User created successfully.")
        |> UserAuth.log_in_user(user)

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  defp default_registration_role() do
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
