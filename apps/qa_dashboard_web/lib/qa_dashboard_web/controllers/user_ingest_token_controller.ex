defmodule QaDashboardWeb.UserIngestTokenController do
  use QaDashboardWeb, :controller
  import Canada, only: [can?: 2]
  alias QaDashboardWeb.AuthorizationError
  alias QaDashboard.Accounts
  alias QaDashboard.Accounts.UserIngestToken
  require Logger

  @object_name "ingest_tokens"

  def index(conn, _params) do
    user = conn.assigns[:current_user]

    if user |> can?(index(@object_name)) do
      user_ingest_tokens = Accounts.list_user_ingest_tokens_by_user(user.id)
      render(conn, "index.html", user_ingest_tokens: user_ingest_tokens)
    else
      AuthorizationError.handle_authorization_error(conn, "index", @object_name)
    end
  end

  def new(conn, _params) do
    user = conn.assigns[:current_user]

    if user |> can?(new(@object_name)) do
      changeset = Accounts.change_user_ingest_token(%UserIngestToken{})
      render(conn, "new.html", changeset: changeset)
    else
      AuthorizationError.handle_authorization_error(conn, "new", @object_name)
    end
  end

  def create(conn, %{"user_ingest_token" => user_ingest_token_params}) do
    token = :crypto.strong_rand_bytes(30) |> Base.url_encode64() |> binary_part(0, 30)
    user = conn.assigns[:current_user]

    if user |> can?(create(@object_name)) do
      case Accounts.create_user_ingest_token(%{
             name: user_ingest_token_params["name"],
             type: user_ingest_token_params["type"],
             token: token,
             user_id: user.id
           }) do
        {:ok, user_ingest_token} ->
          conn
          |> put_flash(:info, "User ingest token created successfully.")
          |> redirect(to: Routes.user_ingest_token_path(conn, :show, user_ingest_token))

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
      user_ingest_token = Accounts.get_user_ingest_token!(id)
      render(conn, "show.html", user_ingest_token: user_ingest_token)
    else
      AuthorizationError.handle_authorization_error(conn, "show", @object_name)
    end
  end

  def edit(conn, %{"id" => id}) do
    user = conn.assigns[:current_user]

    if user |> can?(edit(@object_name)) do
      user_ingest_token = Accounts.get_user_ingest_token!(id)
      changeset = Accounts.change_user_ingest_token(user_ingest_token)
      render(conn, "edit.html", user_ingest_token: user_ingest_token, changeset: changeset)
    else
      AuthorizationError.handle_authorization_error(conn, "edit", @object_name)
    end
  end

  def update(conn, %{"id" => id, "user_ingest_token" => user_ingest_token_params}) do
    user = conn.assigns[:current_user]

    if user |> can?(update(@object_name)) do
      user_ingest_token = Accounts.get_user_ingest_token!(id)

      case Accounts.update_user_ingest_token(user_ingest_token, user_ingest_token_params) do
        {:ok, user_ingest_token} ->
          conn
          |> put_flash(:info, "User ingest token updated successfully.")
          |> redirect(to: Routes.user_ingest_token_path(conn, :show, user_ingest_token))

        {:error, %Ecto.Changeset{} = changeset} ->
          render(conn, "edit.html", user_ingest_token: user_ingest_token, changeset: changeset)
      end
    else
      AuthorizationError.handle_authorization_error(conn, "update", @object_name)
    end
  end

  def delete(conn, %{"id" => id}) do
    user = conn.assigns[:current_user]

    if user |> can?(delete(@object_name)) do
      user_ingest_token = Accounts.get_user_ingest_token!(id)
      {:ok, _user_ingest_token} = Accounts.delete_user_ingest_token(user_ingest_token)

      conn
      |> put_flash(:info, "User ingest token deleted successfully.")
      |> redirect(to: Routes.user_ingest_token_path(conn, :index))
    else
      AuthorizationError.handle_authorization_error(conn, "delete", @object_name)
    end
  end
end
