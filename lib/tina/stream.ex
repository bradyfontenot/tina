defmodule Tina.Stream do
  @moduledoc """
  Provides streaming trade and quote data via Alpaca's data stream

  Available functions:
  open_stream/0
  subscribe/1
  unsubscribe/1
  sub_acct_updates/0
  sub_trade_updates/0


  Callbacks from Websockex
  `handle_connect/2`
  `handle_frame/2`



  Alpaca Market Data Streaming Documentation:
  https://alpaca.markets/docs/api-documentation/api-v2/market-data/streaming/
  """

  # TODO for initial release:
  # Add return value desc to docmodule above
  # write tests
  # terminate socket

  use WebSockex
  alias Tina.Alpaca

  def open_stream() do
    {:ok, pid} = WebSockex.start_link(Alpaca.api_stream_url(), __MODULE__, :state)
    authenticate(pid)
    Process.register(pid, Tina.Stream)
    pid
  end

  @impl true
  def handle_connect(_conn, state) do
    IO.puts("Connected!")
    {:ok, state}
  end

  @impl true
  def handle_frame(_frame = {_, msg}, state) do
    msg
    |> Jason.decode!(keys: :atoms)
    |> IO.inspect(label: "************** \n")

    {:ok, state}
  end

  defp authenticate(pid) do
    {:ok, authentication} =
      %{
        action: "authenticate",
        data: %{key_id: Alpaca.api_key_id(), secret_key: Alpaca.api_secret_key()}
      }
      |> Jason.encode()

    WebSockex.send_frame(pid, {:text, authentication})
  end

  def subscribe(channel_list) do
    {:ok, channels} =
      %{
        action: "listen",
        data: %{streams: channel_list}
      }
      |> Jason.encode()

    WebSockex.send_frame(get_pid(), {:text, channels})
  end

  def unsubscribe(channel_list) do
    {:ok, channels} =
      %{
        action: "unlisten",
        data: %{streams: channel_list}
      }
      |> Jason.encode()

    WebSockex.send_frame(get_pid(), {:text, channels})
  end

  # TEMPORARY - SANDBOX
  # def sub_acct_updates() do
  #   subscribe(["account_updates"])
  # end

  # def sub_trade_updates() do
  #   {:ok, pid} = WebSockex.start_link("wss://paper-api.alpaca.markets/stream", __MODULE__, :state)
  #   authenticate(pid)
  #   Process.register(pid, Tina.Stream)
  #   subscribe(["trade_updates"])
  # end

  defp get_pid(), do: Process.whereis(Tina.Stream)
end

# TODO
# subscribe symbol
# unsubscribe symbol
