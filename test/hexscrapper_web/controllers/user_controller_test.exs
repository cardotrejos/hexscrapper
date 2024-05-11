defmodule HexscrapperWeb.UserControllerTest do
  use HexscrapperWeb.ConnCase, async: true
  alias HexscrapperWeb.Router.Helpers, as: Routes

  @create_attrs %{email: "test@example.com", password: "password123"}
  @invalid_attrs %{email: nil, password: nil}

  describe "register" do
    test "creates user and renders user when data is valid", %{conn: conn} do
      conn = post(conn, Routes.user_path(conn, :register), user: @create_attrs)
      response = json_response(conn, 201)
      assert Map.has_key?(response, "user")
    end

    test "does not create user and renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.user_path(conn, :register), user: @invalid_attrs)
      response = json_response(conn, 422)
      assert Map.has_key?(response, "errors")
    end
  end
end
