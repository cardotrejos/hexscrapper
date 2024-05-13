defimpl Jason.Encoder, for: Scrivener.Page do
  def encode(page, opts) do
    Jason.Encode.map(
      %{
        page_number: page.page_number,
        page_size: page.page_size,
        total_entries: page.total_entries,
        total_pages: page.total_pages,
        entries: page.entries
      },
      opts
    )
  end
end
