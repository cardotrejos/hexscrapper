defmodule Hexscrapper.AccountsTest do
  use Hexscrapper.DataCase, async: true

  alias Hexscrapper.Accounts
  alias Hexscrapper.Accounts.User

  @valid_attrs %{email: "test@example.com", password: "password123"}
  @invalid_attrs %{email: nil, password: nil}

  describe "register_user/1" do
    test "successfully registers a user with valid attributes" do
      assert {:ok, %User{} = user} = Accounts.register_user(@valid_attrs)
      assert user.email == "test@example.com"
      assert Bcrypt.verify_pass("password123", user.password_hash)
    end

    test "fails to register a user with invalid attributes" do
      assert {:error, %Ecto.Changeset{}} = Accounts.register_user(@invalid_attrs)
    end

    test "fails to register a user with an already taken email" do
      assert {:ok, %User{}} = Accounts.register_user(@valid_attrs)
      assert {:error, %Ecto.Changeset{}} = Accounts.register_user(@valid_attrs)
    end
  end

  describe "authenticate_user/2" do
    setup do
      {:ok, user} = Accounts.register_user(@valid_attrs)
      {:ok, user: user}
    end

    test "successfully authenticates a user with valid credentials", %{user: user} do
      {:ok, auth_user} = Accounts.authenticate_user("test@example.com", "password123")
      assert auth_user.id == user.id
      assert auth_user.email == user.email
    end

    test "fails to authenticate a user with invalid credentials", %{user: _user} do
      assert {:error, :unauthorized} = Accounts.authenticate_user("test@example.com", "wrongpassword")
    end

    test "fails to authenticate a non-existent user" do
      assert {:error, :unauthorized} = Accounts.authenticate_user("nonexistent@example.com", "password123")
    end
  end
end
