defmodule Hexscrapper.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      HexscrapperWeb.Telemetry,
      Hexscrapper.Repo,
      {DNSCluster, query: Application.get_env(:hexscrapper, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: Hexscrapper.PubSub},
      # Start a worker by calling: Hexscrapper.Worker.start_link(arg)
      # {Hexscrapper.Worker, arg},
      # Start to serve requests, typically the last entry
      HexscrapperWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Hexscrapper.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    HexscrapperWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
