defmodule QaDashboardWeb.UserSettingsController do
  use QaDashboardWeb, :controller
  import Canada, only: [can?: 2]
  alias QaDashboardWeb.AuthorizationError

  alias QaDashboard.Accounts
  alias QaDashboardWeb.UserAuth

  plug :assign_email_and_password_changesets
  @object_name "user_settings"
  def edit(conn, _params) do
    user = conn.assigns[:current_user]

    if user |> can?(edit(@object_name)) do
      render(conn, "edit.html")
    else
      AuthorizationError.handle_authorization_error(conn, "edit", @object_name)
    end
  end

  def update_email(conn, %{"current_password" => password, "user" => user_params}) do
    user = conn.assigns.current_user

    if user |> can?(update_email(@object_name)) do
      case Accounts.apply_user_email(user, password, user_params) do
        {:ok, applied_user} ->
          Accounts.deliver_update_email_instructions(
            applied_user,
            user.email,
            &Routes.user_settings_url(conn, :confirm_email, &1)
          )

          conn
          |> put_flash(
            :info,
            "A link to confirm your e-mail change has been sent to the new address."
          )
          |> redirect(to: Routes.user_settings_path(conn, :edit))

        {:error, changeset} ->
          render(conn, "edit.html", email_changeset: changeset)
      end
    else
      AuthorizationError.handle_authorization_error(conn, "update_email", @object_name)
    end
  end

  def confirm_email(conn, %{"token" => token}) do
    user = conn.assigns.current_user

    if user |> can?(confirm_email(@object_name)) do
      case Accounts.update_user_email(conn.assigns.current_user, token) do
        :ok ->
          conn
          |> put_flash(:info, "E-mail changed successfully.")
          |> redirect(to: Routes.user_settings_path(conn, :edit))

        :error ->
          conn
          |> put_flash(:error, "Email change link is invalid or it has expired.")
          |> redirect(to: Routes.user_settings_path(conn, :edit))
      end
    else
      AuthorizationError.handle_authorization_error(conn, "confirm_email", @object_name)
    end

  end

  def update_password(conn, %{"current_password" => password, "user" => user_params}) do
    user = conn.assigns.current_user
    if user |> can?(update_password(@object_name)) do
      case Accounts.update_user_password(user, password, user_params) do
        {:ok, user} ->
          conn
          |> put_flash(:info, "Password updated successfully.")
          |> put_session(:user_return_to, Routes.user_settings_path(conn, :edit))
          |> UserAuth.log_in_user(user)

        {:error, changeset} ->
          render(conn, "edit.html", password_changeset: changeset)
      end
    else
      AuthorizationError.handle_authorization_error(conn, "update_password", @object_name)
    end

  end

  defp assign_email_and_password_changesets(conn, _opts) do
    user = conn.assigns.current_user

    conn
    |> assign(:email_changeset, Accounts.change_user_email(user))
    |> assign(:password_changeset, Accounts.change_user_password(user))
  end
end
