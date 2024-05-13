defmodule HexscrapperWeb.PageController do
  use HexscrapperWeb, :controller
  alias Hexscrapper.{Scraper, Pages, Links}
  alias Hexscrapper.Repo

  def create(conn, %{"url" => url}) do
    case Scraper.scrape_page(url) do
      {:ok, %{title: title, links: links}} ->
        case Pages.create_page(%{url: url, title: title}) do
          {:ok, page} ->
            timestamps =
                NaiveDateTime.utc_now()
                |> NaiveDateTime.truncate(:second)
                |> DateTime.from_naive!("Etc/UTC")
            link_attrs =
              Enum.map(links, fn link ->
                %{
                  href: link.href,
                  name: link.name,
                  page_id: page.id,
                  inserted_at: timestamps,
                  updated_at: timestamps
                }
              end)

            case Repo.insert_all(Links.Link, link_attrs, on_conflict: :nothing) do
                {_inserted_count, _} ->
                page = Pages.get_page_with_links!(page.id)

                conn
                |> put_status(:created)
                |> json(%{page: page, links: page.links})
            end

          {:error, changeset} ->
            conn
            |> put_status(:unprocessable_entity)
            |> json(%{errors: changeset_errors(changeset)})
        end

      {:error, reason} ->
        conn
        |> put_status(:unprocessable_entity)
        |> json(%{error: reason})
    end
  end

  def index(conn, _params) do
    pages = Pages.list_pages()

    conn
    |> put_view(HexscrapperWeb.PageJSON)
    |> render("index.json", pages: pages)
  end

  def show(conn, %{"id" => id}) do
    page = Pages.get_page_with_links!(id)

    conn
    |> put_view(HexscrapperWeb.PageJSON)
    |> render("show.json", page: page)
  end

  defp changeset_errors(changeset) do
    Ecto.Changeset.traverse_errors(changeset, fn {msg, opts} ->
      Enum.reduce(opts, msg, fn {key, value}, acc ->
        String.replace(acc, "%{#{key}}", to_string(value))
      end)
    end)
  end
end
