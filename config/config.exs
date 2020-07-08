use Mix.Config

apca_api_key_id =
  System.get_env("APCA_API_KEY_ID") ||
    raise """
    environment variable APCA_API_KEY_ID is missing.
    """

apca_api_secret_key =
  System.get_env("APCA_API_SECRET_KEY") ||
    raise """
    environment variable APCA_API_SECRET_KEY is missing.
    """

apca_api_base_url =
  System.get_env("APCA_API_BASE_URL") ||
    raise """
    environment variable APCA_API_BASE_URL is missing.
    """

apca_api_stream_url =
  System.get_env("APCA_API_STREAM_URL") ||
    raise """
    environment variable APCA_API_STREAM_URL is missing.
    """

config :tina, apca_api_key_id: apca_api_key_id
config :tina, apca_api_secret_key: apca_api_secret_key
config :tina, apca_api_base_url: apca_api_base_url
config :tina, apca_api_stream_url: apca_api_stream_url

# Use Hackney as default adapter for Tesla
config :tesla, adapter: Tesla.Adapter.Hackney

# Use Jason for JSON parsing in Phoenix
config :tina, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
# import_config "#{Mix.env()}.exs"
