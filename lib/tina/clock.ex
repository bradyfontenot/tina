defmodule Tina.Clock do
  @moduledoc """
  Returns the current market timestamp, whether or not the market is currently open,
  as well as the times of the next market open and close

  Available functions:
  get/0

  Alpaca Markets Clock Documentation:
  https://alpaca.markets/docs/api-documentation/api-v2/clock/
  """

  # TODO for initial release:
  # Add return value desc to docmodule above
  # write tests

  alias Tina.Alpaca

  @endpoint "clock"

  @type t :: %__MODULE__{
          is_open: boolean(),
          next_close: String.t(),
          next_open: String.t(),
          timestamp: String.t()
        }

  defstruct [
    :is_open,
    :next_open,
    :next_close,
    :timestamp
  ]

  @doc """
  get/0 returns the market clock.
  """
  @spec get() :: tuple()
  def get() do
    Alpaca.get_data(@endpoint, struct(Tina.Clock))
  end
end
