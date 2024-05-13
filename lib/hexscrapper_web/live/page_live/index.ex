defmodule HexscrapperWeb.PageLive.Index do
  use HexscrapperWeb, :live_view
  alias Hexscrapper.Pages

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, pages: Pages.list_pages())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    page_number = Map.get(params, "page", "1") |> String.to_integer()
    page = Pages.get_page_with_links!(page_number)

    {:noreply, assign(socket, page: page, page_number: page_number)}
  end

  @impl true
  @spec handle_event(<<_::64>>, map(), any()) :: {:noreply, any()}
  def handle_event("paginate", %{"page" => page_number}, socket) do
    page_number = String.to_integer(page_number)
    page = Pages.get_page_with_links!(page_number)

    {:noreply, assign(socket, page: page, page_number: page_number)}
  end
end
