defmodule PoetryGameApi.Repo do
  use Ecto.Repo,
    otp_app: :poetry_game_api,
    adapter: Ecto.Adapters.Postgres
end
