defmodule QaDashboardWeb.AuthorizationError do
  @moduledoc """
  Error handler for authorization errors
  """
  import Plug.Conn
  import Phoenix.Controller
  alias QaDashboardWeb.Router.Helpers, as: Routes

  def handle_authorization_error(conn, action, module_name) do
    conn
    |> clear_session()
    |> put_flash(
      :error,
      "Authorization Error, you do not have access to: " <> action <> " on " <> module_name
    )
    |> redirect(to: Routes.page_path(conn, :index))
  end
end
