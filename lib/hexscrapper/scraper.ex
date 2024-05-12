defmodule Hexscrapper.Scraper do
  require Logger

  def scrape_page(url) do
    case HTTPoison.get(url) do
      {:ok, %HTTPoison.Response{body: body}} ->
        parse_links(body)

      {:error, %HTTPoison.Error{reason: reason}} ->
        {:error, reason}
    end
  end

  defp parse_links(body) do
    case Floki.parse_document(body) do
      {:ok, document} ->
        title = document |> Floki.find("title") |> Floki.text()

        links =
          Floki.find(document, "a")
          |> Enum.map(fn link ->
            href = Floki.attribute(link, "href") |> List.first()
            name = Floki.text(link)
            %{href: href, name: name}
          end)

        {:ok, %{title: title, links: links}}

      {:error, reason} ->
        {:error, reason}
    end
  end
end
