defmodule Tina.Stream do
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

  def authenticate(pid) do
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

  def sub_trade_updates() do
    {:ok, channel} =
      %{
        action: "listen",
        data: %{streams: ["channel_list"]}
      }
      |> Jason.encode()

    WebSockex.send_frame(get_pid(), {:text, channel})
  end

  defp get_pid(), do: Process.whereis(Tina.Stream)

end

# TODO
# subscribe symbol
# unsubscribe symbol
