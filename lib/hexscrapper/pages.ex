defmodule Hexscrapper.Pages do
  @moduledoc """
  The Pages context.
  """

  import Ecto.Query, warn: false
  alias Hexscrapper.Repo
  alias Hexscrapper.Pages.Page

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

  @doc """
  Updates a page.
  """
  def update_page(%Page{} = page, attrs) do
    page
    |> Page.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a page.
  """
  def delete_page(%Page{} = page) do
    Repo.delete(page)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking page changes.
  """
  def change_page(%Page{} = page, attrs \\ %{}) do
    Page.changeset(page, attrs)
  end

  def get_page_with_links!(id) do
    Page
    |> Repo.get!(id)
    |> Repo.preload(:links)
  end
end
