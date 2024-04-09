defmodule PhoenixCore.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      PhoenixCoreWeb.Telemetry,
      PhoenixCore.Repo,
      {DNSCluster, query: Application.get_env(:phoenix_core, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: PhoenixCore.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: PhoenixCore.Finch},
      # Start a worker by calling: PhoenixCore.Worker.start_link(arg)
      # {PhoenixCore.Worker, arg},
      # Start to serve requests, typically the last entry
      PhoenixCoreWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: PhoenixCore.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    PhoenixCoreWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
