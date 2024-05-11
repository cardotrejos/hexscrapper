defmodule Hexscrapper.Accounts do
  alias Hexscrapper.Repo
  alias Hexscrapper.Accounts.User

  def register_user(attrs) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end

  def authenticate_user(email, password) do
    user = Repo.get_by(User, email: email)

    if user && is_binary(user.password_hash) && Bcrypt.verify_pass(password, user.password_hash) do
      {:ok, user}
    else
      {:error, :unauthorized}
    end
  end
end
