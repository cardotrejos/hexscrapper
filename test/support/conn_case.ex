defmodule HexscrapperWeb.ConnCase do
  use ExUnit.CaseTemplate

  using do
    quote do
      # Import conveniences for testing with connections
      import Plug.Conn
      import Phoenix.ConnTest
      alias HexscrapperWeb.Router.Helpers, as: Routes

      # The default endpoint for testing
      @endpoint HexscrapperWeb.Endpoint
    end
  end

  setup tags do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(Hexscrapper.Repo)
    unless tags[:async] do
      Ecto.Adapters.SQL.Sandbox.mode(Hexscrapper.Repo, {:shared, self()})
    end
    {:ok, conn: Phoenix.ConnTest.build_conn()}
  end
end
