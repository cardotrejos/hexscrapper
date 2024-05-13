defmodule Hexscrapper.Repo do
  use Ecto.Repo,
    otp_app: :hexscrapper,
    adapter: Ecto.Adapters.Postgres

  use Scrivener, page_size: 10
end
