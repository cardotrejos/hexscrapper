defmodule HexscrapperWeb.PageLive do
  use HexscrapperWeb, :live_view
  alias Hexscrapper.Pages

  def mount(_params, _session, socket) do
    {:ok, assign(socket, pages: Pages.list_pages())}
  end
end
