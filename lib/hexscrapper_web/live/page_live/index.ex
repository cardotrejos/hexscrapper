defmodule HexscrapperWeb.PageLive.Index do
  use HexscrapperWeb, :live_view
  alias Hexscrapper.{Pages, Scraper}

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, url: "", page: 1, pages: [], error: nil)}
  end

  @impl true
  def handle_params(params, _url, socket) do
    page_number = String.to_integer(params["page"] || "1")
    pages = Pages.list_pages(page: page_number, page_size: 10)

    socket =
      socket
      |> assign(:page_title, "Listing Pages")
      |> assign(:page_number, page_number)
      |> assign(:pages, pages)

    {:noreply, socket}
  end

  @impl true
  def handle_event("scrape", %{"url" => url}, socket) do
    case Scraper.scrape_page(url) do
      {:ok, %{title: title, links: links}} ->
        {:ok, page} = Pages.create_page(%{url: url, title: title})
        Pages.create_links(page, links)
        {:noreply, assign(socket, url: "", error: nil)}

      {:error, reason} ->
        {:noreply, assign(socket, error: reason)}
    end
  end

  def handle_event("change_url", %{"url" => url}, socket) do
    {:noreply, assign(socket, url: url)}
  end


  defp page_title(:show), do: "Show Page"
  defp page_title(:index), do: "Listing Pages"
end
