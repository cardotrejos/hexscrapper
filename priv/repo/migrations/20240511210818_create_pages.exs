defmodule Hexscrapper.Repo.Migrations.CreatePages do
  use Ecto.Migration

  def change do
    create table(:pages) do
      add :url, :string
      add :title, :string

      timestamps(type: :utc_datetime)
    end
  end
end
