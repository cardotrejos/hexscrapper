defmodule Hexscrapper.Pages do
  @moduledoc """
  The Pages context.
  """

  import Ecto.Query, warn: false
  alias Hexscrapper.Repo
  alias Hexscrapper.Pages.Page
  alias Hexscrapper.Links

  @doc """
  Returns the list of pages.
  """
  def list_pages do
    Repo.all(Page)
  end

  @doc """
  Gets a single page.
  Raises `Ecto.NoResultsError` if the Page does not exist.
  """
  def get_page!(id), do: Repo.get!(Page, id)

  @doc """
  Creates a page.
  """
  def create_page(attrs \\ %{}) do
    %Page{}
    |> Page.changeset(attrs)
    |> Repo.insert()
  end

  def get_page_with_links!(id, params \\ %{}) do
    page = Repo.get!(Page, id)
    links = Links.get_links_by_page_id(page.id, params)
    %{page: page, links: links.entries, pagination: links}
  end
end
