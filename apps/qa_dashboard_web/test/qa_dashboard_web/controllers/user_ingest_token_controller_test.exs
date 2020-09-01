defmodule QaDashboardWeb.UserIngestTokenControllerTest do
  use QaDashboardWeb.ConnCase

  alias QaDashboard.Accounts

  setup :register_and_log_in_user

  @create_attrs %{name: "some name", token: "some token", type: "some type"}
  @update_attrs %{
    name: "some updated name",
    token: "some updated token",
    type: "some updated type"
  }
  @invalid_attrs %{name: nil, token: nil, type: nil}

  def fixture(:user_ingest_token) do
    {:ok, user_ingest_token} = Accounts.create_user_ingest_token(@create_attrs)
    user_ingest_token
  end

  describe "index" do
    test "lists all user_ingest_tokens", %{conn: conn} do
      conn = get(conn, Routes.user_ingest_token_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing User ingest tokens"
    end
  end

  describe "new user_ingest_token" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.user_ingest_token_path(conn, :new))
      assert html_response(conn, 200) =~ "New User ingest token"
    end
  end

  describe "create user_ingest_token" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn =
        post(conn, Routes.user_ingest_token_path(conn, :create), user_ingest_token: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.user_ingest_token_path(conn, :show, id)

      conn = get(conn, Routes.user_ingest_token_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show User ingest token"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn =
        post(conn, Routes.user_ingest_token_path(conn, :create), user_ingest_token: @invalid_attrs)

      assert html_response(conn, 200) =~ "New User ingest token"
    end
  end

  describe "edit user_ingest_token" do
    setup [:create_user_ingest_token]

    test "renders form for editing chosen user_ingest_token", %{
      conn: conn,
      user_ingest_token: user_ingest_token
    } do
      conn = get(conn, Routes.user_ingest_token_path(conn, :edit, user_ingest_token))
      assert html_response(conn, 200) =~ "Edit User ingest token"
    end
  end

  describe "update user_ingest_token" do
    setup [:create_user_ingest_token]

    test "redirects when data is valid", %{conn: conn, user_ingest_token: user_ingest_token} do
      conn =
        put(conn, Routes.user_ingest_token_path(conn, :update, user_ingest_token),
          user_ingest_token: @update_attrs
        )

      assert redirected_to(conn) == Routes.user_ingest_token_path(conn, :show, user_ingest_token)

      conn = get(conn, Routes.user_ingest_token_path(conn, :show, user_ingest_token))
      assert html_response(conn, 200) =~ "some updated name"
    end

    test "renders errors when data is invalid", %{
      conn: conn,
      user_ingest_token: user_ingest_token
    } do
      conn =
        put(conn, Routes.user_ingest_token_path(conn, :update, user_ingest_token),
          user_ingest_token: @invalid_attrs
        )

      assert html_response(conn, 200) =~ "Edit User ingest token"
    end
  end

  describe "delete user_ingest_token" do
    setup [:create_user_ingest_token]

    test "deletes chosen user_ingest_token", %{conn: conn, user_ingest_token: user_ingest_token} do
      conn = delete(conn, Routes.user_ingest_token_path(conn, :delete, user_ingest_token))
      assert redirected_to(conn) == Routes.user_ingest_token_path(conn, :index)

      assert_error_sent 404, fn ->
        get(conn, Routes.user_ingest_token_path(conn, :show, user_ingest_token))
      end
    end
  end

  defp create_user_ingest_token(_) do
    user_ingest_token = fixture(:user_ingest_token)
    %{user_ingest_token: user_ingest_token}
  end
end
