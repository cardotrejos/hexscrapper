defmodule HexscrapperWeb.PageLive.Show do
  use HexscrapperWeb, :live_view
  alias Hexscrapper.Pages

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:page, Pages.get_page_with_links!(id))}
  end

  defp page_title(:show), do: "Show Page"
  defp page_title(:edit), do: "Edit Page"
end
