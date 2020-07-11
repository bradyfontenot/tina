defmodule Tina.Account.Portfolio.History do
  @moduledoc """
  Returns timeseries data about equity and profit/loss
  of the account in requested timespan

  Available functions:
  `list/0`
  `filtered_by/1`

  Alpaca Markets Portfolio History Documentation:
  https://alpaca.markets/docs/api-documentation/api-v2/portfolio-history/
  """

  # TODO for initial release:
  # Add return value desc to docmodule above
  # write tests

  alias Tina.Alpaca

  @endpoint "account/portfolio/history"

  @type t :: %__MODULE__{
          base_value: integer(),
          equity: list(float()),
          profit_loss: list(float()),
          profit_loss_pct: list(float()),
          timeframe: String.t(),
          timestamp: list(integer())
        }

  defstruct [
    :base_value,
    :equity,
    :profit_loss,
    :profit_loss_pct,
    :timeframe,
    :timestamp
  ]

  @doc """
    `list/0` returns full history based on a daily timeframe.
  """
  @spec list() :: tuple()
  def list() do
    Alpaca.get_data(@endpoint, struct(Tina.Account.Portfolio.History))
  end

  @doc """
    `filtered_by/1` returns history based on supplied params.
    query must be supplied as keyword list.

    valid params:
      :period <string>
      :timeframe <string>
      :date_start <string> "YYYY-MM-DD" (omitted in Alpaca Docs)
      :date_end <string> "YYYY-MM-DD"
      :extended_hours <bool>
  """
  @spec filtered_by([key: String.t() | boolean()]) :: tuple()
  def filtered_by(query \\ []) do
    Alpaca.get_data(@endpoint, query, struct(Tina.Account.Portfolio.History))
  end
end
