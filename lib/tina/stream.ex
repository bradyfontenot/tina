defmodule Tina.Stream do
  use WebSockex

  @apca_api_key_id Application.get_env(:tina, :apca_api_key_id)
  @apca_api_secret_key Application.get_env(:tina, :apca_api_secret_key)
  @apca_api_stream_url Application.get_env(:tina, :apca_api_stream_url)

  def open_stream() do
    {:ok, pid} = WebSockex.start_link(@apca_api_stream_url, __MODULE__, :state)
    authenticate(pid)
    Process.register(pid, Tina.Stream)
    pid
  end

  def handle_connect(conn, state) do
    IO.puts("Connected!")
    {:ok, state}
  end

  def handle_frame(frame = {:text, msg}, state) do
    msg
    |> Jason.decode()
    |> IO.inspect(label: "**************")

    {:ok, state}
  end

  def authenticate(pid) do
    {:ok, authentication} =
      %{
        action: "authenticate",
        data: %{key_id: @apca_api_key_id, secret_key: @apca_api_secret_key}
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

  defp get_pid(), do: Process.whereis(Tina.Stream)

end

# {"action": "listen", "data": {"streams": ["TQ.SPY", "AM.SPY"]}}

# {"action": "authenticate", "data": {"key_id": "PKLVCMLTKRKJUVFQZSHC", "secret_key": "q7ZK/IxHaMZF2PiAGHJ4Y/wsSGwoxHhBxmCUNTum"}}
