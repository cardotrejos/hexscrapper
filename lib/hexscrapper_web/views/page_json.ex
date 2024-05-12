defmodule HexscrapperWeb.PageJSON do

  def index(%{pages: pages}) do
    %{
      data: Enum.map(pages, &page_json/1)
    }
  end

  def show(%{page: page}) do
  %{
    data: %{
      page: page_json(page),
      links: Enum.map(page.links, &link_json/1)
    }
  }
end


  defp page_json(page) do
    %{
      id: page.id,
      url: page.url,
      title: page.title,
      inserted_at: page.inserted_at,
      updated_at: page.updated_at

    }
  end

  defp link_json(link) do
    %{
      id: link.id,
      href: link.href,
      name: link.name,
      page_id: link.page_id,
      inserted_at: link.inserted_at,
      updated_at: link.updated_at
    }
  end
end
