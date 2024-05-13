defmodule Hexscrapper.Pages do
  @moduledoc """
  The Pages context.
  """

  import Ecto.Query, warn: false
  alias Hexscrapper.Repo
  alias Hexscrapper.Pages.Page
  alias Hexscrapper.Links

  # @doc """
  # Returns the list of pages.
  # """
  # def list_pages do
  #   Repo.all(Page)
  # end

  @doc """
  Gets a single page.
  Raises `Ecto.NoResultsError` if the Page does not exist.
  """
  def get_page!(id), do: Repo.get!(Page, id)

  @doc """
  Creates a page.
  """
  def list_pages(params \\ []) do
    params = Enum.into(params, %{})
    page = Map.get(params, :page, 1)
    page_size = Map.get(params, :page_size, 10)

    Page
    |> order_by(desc: :inserted_at)
    |> preload(:links)
    |> Repo.paginate(page: page, page_size: page_size)
  end

  def create_page(attrs \\ %{}) do
    %Page{}
    |> Page.changeset(attrs)
    |> Repo.insert()
  end

  def create_links(page, links) do
    timestamp =
      NaiveDateTime.utc_now()
      |> NaiveDateTime.truncate(:second)
      |> DateTime.from_naive!("Etc/UTC")

    link_attrs =
      Enum.map(links, fn link ->
        %{
          href: link.href,
          name: link.name,
          page_id: page.id,
          inserted_at: timestamp,
          updated_at: timestamp
        }
      end)

    Repo.insert_all(Links.Link, link_attrs, on_conflict: :nothing)
  end

  def get_page_with_links!(id, params \\ %{}) do
    page = Repo.get!(Page, id)
    links = Links.get_links_by_page_id(page.id, params)
    %{page: page, links: links.entries, pagination: links}
  end
end
