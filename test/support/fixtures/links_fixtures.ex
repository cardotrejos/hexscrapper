defmodule Hexscrapper.LinksFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Hexscrapper.Links` context.
  """

  @doc """
  Generate a link.
  """
  def link_fixture(attrs \\ %{}) do
    {:ok, link} =
      attrs
      |> Enum.into(%{
        href: "some href",
        name: "some name"
      })
      |> Hexscrapper.Links.create_link()

    link
  end
end
