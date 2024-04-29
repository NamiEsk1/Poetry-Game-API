defmodule PoetryGameApiWeb.Endpoint do
  use Phoenix.Endpoint, otp_app: :poetry_game_api

  # The session will be stored in the cookie and signed,
  # this means its contents can be read but not tampered with.
  # Set :encryption_salt if you would also like to encrypt it.
  @session_options [
    store: :cookie,
    key: "_poetry_game_api_key",
    signing_salt: "7wSNshdu",
    same_site: "Lax"
  ]

  # socket "/live", Phoenix.LiveView.Socket,
  #   websocket: [connect_info: [session: @session_options]],
  #   longpoll: [connect_info: [session: @session_options]]

  # Serve at "/" the static files from "priv/static" directory.
  #
  # You should set gzip to true if you are running phx.digest
  # when deploying your static files in production.
  plug Plug.Static,
    at: "/",
    from: :poetry_game_api,
    gzip: false,
    only: PoetryGameApiWeb.static_paths()

  # Code reloading can be explicitly enabled under the
  # :code_reloader configuration of your endpoint.
  if code_reloading? do
    plug Phoenix.CodeReloader
    plug Phoenix.Ecto.CheckRepoStatus, otp_app: :poetry_game_api
  end

  plug Plug.RequestId
  plug Plug.Telemetry, event_prefix: [:phoenix, :endpoint]

  plug Plug.Parsers,
    parsers: [:urlencoded, :multipart, :json],
    pass: ["*/*"],
    json_decoder: Phoenix.json_library()

  plug Corsica,
    origins: Application.compile_env(:poetry_game_api, :origins),
    allow_headers: ["Accept", "Content-Type"],
    allow_credentials: true

  plug Plug.MethodOverride
  plug Plug.Head
  plug Plug.Session, @session_options
  plug PoetryGameApiWeb.Router
end
