defmodule Tina.Clock do
  use Tesla
  alias Tina.Alpaca

  @endpoint "clock"

  @doc """
  Calendar struct matches k,v from /account endpoint
  """
  defstruct [
    :timestamp,
    :is_open,
    :next_open,
    :next_close
  ]

  def get_clock() do
    Alpaca.get_data(@endpoint, struct(Tina.Clock))
  end
end
