defmodule HexscrapperWeb.PageController do
  use HexscrapperWeb, :controller
  alias Hexscrapper.{Scraper, Pages}

  def create(conn, %{"url" => url}) do
    case URI.parse(url) do
      %URI{scheme: "http" <> _} ->
        case Scraper.scrape_page(url) do
          {:ok, %{title: title, links: links}} ->
            case Pages.create_page(%{url: url, title: title}) do
              {:ok, page} ->
                case Pages.create_links(page, links) do
                  {_inserted_count, _} ->
                    page = Pages.get_page_with_links!(page.id)

                    conn
                    |> put_status(:created)
                    |> json(%{page: page, links: page.links})

                  _ ->
                    conn
                    |> put_status(:internal_server_error)
                    |> json(%{error: "Failed to create links"})
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

      _ ->
        conn
        |> put_status(:bad_request)
        |> json(%{error: "Invalid URL"})
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
