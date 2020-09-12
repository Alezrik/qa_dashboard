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
    user_ingest_tokens = Accounts.list_user_ingest_tokens_by_user(user.id)
    render(conn, "index.html", user_ingest_tokens: user_ingest_tokens)
  end

  def new(conn, _params) do
    changeset = Accounts.change_user_ingest_token(%UserIngestToken{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"user_ingest_token" => user_ingest_token_params}) do
    token = :crypto.strong_rand_bytes(30) |> Base.url_encode64() |> binary_part(0, 30)
    user = conn.assigns[:current_user]

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
  end

  def show(conn, %{"id" => id}) do
    user_ingest_token = Accounts.get_user_ingest_token!(id)
    render(conn, "show.html", user_ingest_token: user_ingest_token)
  end

  def edit(conn, %{"id" => id}) do
    user_ingest_token = Accounts.get_user_ingest_token!(id)
    changeset = Accounts.change_user_ingest_token(user_ingest_token)
    render(conn, "edit.html", user_ingest_token: user_ingest_token, changeset: changeset)
  end

  def update(conn, %{"id" => id, "user_ingest_token" => user_ingest_token_params}) do
    user_ingest_token = Accounts.get_user_ingest_token!(id)

    case Accounts.update_user_ingest_token(user_ingest_token, user_ingest_token_params) do
      {:ok, user_ingest_token} ->
        conn
        |> put_flash(:info, "User ingest token updated successfully.")
        |> redirect(to: Routes.user_ingest_token_path(conn, :show, user_ingest_token))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", user_ingest_token: user_ingest_token, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    user_ingest_token = Accounts.get_user_ingest_token!(id)
    {:ok, _user_ingest_token} = Accounts.delete_user_ingest_token(user_ingest_token)

    conn
    |> put_flash(:info, "User ingest token deleted successfully.")
    |> redirect(to: Routes.user_ingest_token_path(conn, :index))
  end
end
