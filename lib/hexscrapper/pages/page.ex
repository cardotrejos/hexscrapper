defmodule Hexscrapper.Pages.Page do
  use Ecto.Schema
  import Ecto.Changeset

  @derive {Jason.Encoder, only: [:id, :url, :title]}
  schema "pages" do
    field :url, :string
    field :title, :string
    has_many :links, Hexscrapper.Links.Link

    timestamps()
  end

  def changeset(page, attrs) do
    page
    |> cast(attrs, [:url, :title])
    |> validate_required([:url, :title])
  end
end
