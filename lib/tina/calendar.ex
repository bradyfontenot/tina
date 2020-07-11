defmodule Tina.Calendar do
  @moduledoc """
  Returns market calendar info either in full
  or filtered by a given date range.

  Available functions:
  get/0
  filtered_by_date/2

  Alpaca Markets Calendar Documentation:
  https://alpaca.markets/docs/api-documentation/api-v2/calendar
  """

  # TODO for initial release:
  # refactor filtered_by_date/2
  # Add return value desc to docmodule above
  # write tests

  use Tesla
  alias Tina.Alpaca

  @endpoint "calendar"

  @type t :: %__MODULE__{
          date: String.t(),
          session_open: String.t(),
          session_close: String.t()
        }

  defstruct [
    :date,
    :session_open,
    :session_close
  ]

  @doc """
    get/0 returns a full list of market days from 1970 - 2029
  """
  @spec get() :: tuple()
  def get() do
    Alpaca.get_data(@endpoint, struct(Tina.Calendar))
  end

  @doc """
  filtered_by_date/2 returns calendar of market days
  between the given date range

  If only start_date is supplied, values returned will be from start date to 2029.
  If only end_date is supplied, values returned will be from 1970 to end date.
  If no dates are supplied, the entire calendar will be return same as get/0.

  supplied dates must be a string in ISO format:
  "2020-06-26T19:32:06+00:00"
  """
  @spec filtered_by_date(String.t(), String.t()) :: tuple()
  def filtered_by_date(start_date \\ "", end_date \\ "") do
    Alpaca.get_data(@endpoint, [start: start_date, end: end_date], struct(Tina.Calendar))
  end
end
