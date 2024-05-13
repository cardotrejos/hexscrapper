defmodule HexscrapperWeb.PageLive.Index do
  use HexscrapperWeb, :live_view
  alias Hexscrapper.Pages

  @impl true
  def mount(_params, _session, socket) do
    pages = Pages.list_pages() |> Hexscrapper.Repo.preload(:links)
    {:ok, assign(socket, pages: pages)}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Pages")
    |> assign(:page, nil)
  end

  defp apply_action(socket, :show, %{"id" => id}) do
    socket
    |> assign(:page_title, page_title(socket.assigns.live_action))
    |> assign(:page, Pages.get_page_with_links!(id))
  end

  defp page_title(:show), do: "Show Page"
  defp page_title(:index), do: "Listing Pages"
end
