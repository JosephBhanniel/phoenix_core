defmodule PhoenixCore.Repo do
  use Ecto.Repo,
    otp_app: :phoenix_core,
    adapter: Ecto.Adapters.Postgres
end
