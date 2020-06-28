defmodule Tina.Calendar do
  use Tesla
  alias Tina.Alpaca

  @endpoint "calendar"

  @doc """
  Calendar struct matches k,v from /account endpoint
  """
  defstruct [
    :date,
    :session_open,
    :session_close
  ]

  def get_calendar() do
    Alpaca.get_data(@endpoint, struct(Tina.Calendar))
  end

  @doc """
    date must be a string in ISO format
    Example:
      06/26/2020 @ 7:32pm (UTC)
      ISO: "2020-06-26T19:32:06+00:00"
  """
  def filter_by_date(start_date, end_date) do
    Alpaca.get_data(@endpoint, [start: start_date, end: end_date], struct(Tina.Calendar))
  end
end
