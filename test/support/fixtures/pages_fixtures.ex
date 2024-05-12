defmodule Hexscrapper.PagesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Hexscrapper.Pages` context.
  """

  @doc """
  Generate a page.
  """
  def page_fixture(attrs \\ %{}) do
    {:ok, page} =
      attrs
      |> Enum.into(%{
        title: "some title",
        url: "some url"
      })
      |> Hexscrapper.Pages.create_page()

    page
  end
end
