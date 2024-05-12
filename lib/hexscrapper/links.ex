defmodule Hexscrapper.Links do
  @moduledoc """
  The Links context.
  """

  import Ecto.Query, warn: false
  alias Hexscrapper.Repo
  alias Hexscrapper.Links.Link

  @doc """
  Returns the list of links.
  """
  def list_links do
    Repo.all(Link)
  end

  @doc """
  Gets a single link.
  Raises `Ecto.NoResultsError` if the Link does not exist.
  """
  def get_link!(id), do: Repo.get!(Link, id)

  @doc """
  Creates a link.
  """
  def create_link(attrs \\ %{}) do
    %Link{}
    |> Link.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a link.
  """
  def update_link(%Link{} = link, attrs) do
    link
    |> Link.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a link.
  """
  def delete_link(%Link{} = link) do
    Repo.delete(link)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking link changes.
  """
  def change_link(%Link{} = link, attrs \\ %{}) do
    Link.changeset(link, attrs)
  end

  @doc """
  Gets links by page ID.
  """
  def get_links_by_page_id(page_id) do
    Repo.all(from l in Link, where: l.page_id == ^page_id)
  end
end
