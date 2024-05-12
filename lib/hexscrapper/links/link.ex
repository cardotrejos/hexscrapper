defmodule Hexscrapper.Links.Link do
  use Ecto.Schema
  import Ecto.Changeset

  @derive {Jason.Encoder, only: [:id, :href, :name, :page_id, :inserted_at, :updated_at]}

  schema "links" do
    field :name, :string
    field :href, :string
    field :page_id, :id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(link, attrs) do
    link
    |> cast(attrs, [:href, :name])
    |> validate_required([:href, :name])
  end
end
