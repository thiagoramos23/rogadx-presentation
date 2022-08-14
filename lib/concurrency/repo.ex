defmodule Concurrency.Repo do
  use Ecto.Repo,
    otp_app: :concurrency,
    adapter: Ecto.Adapters.Postgres
end
