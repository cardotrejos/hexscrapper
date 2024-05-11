defmodule Hexscrapper.Repo do
  use Ecto.Repo,
    otp_app: :hexscrapper,
    adapter: Ecto.Adapters.Postgres
end
