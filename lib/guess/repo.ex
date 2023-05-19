defmodule Guess.Repo do
  use Ecto.Repo,
    otp_app: :guess,
    adapter: Ecto.Adapters.Postgres
end
