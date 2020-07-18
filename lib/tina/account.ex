defmodule Tina.Account do
  @moduledoc """
  Returns important information related to an account,
  including account status, funds available for trade, funds available
  for withdrawal, and various flags relevant to an account’s ability to trade.

  Available functions:
  `get/0`

  Alpaca Markets Account Documentation:
  https://alpaca.markets/docs/api-documentation/api-v2/account
  """

  # TODO for initial release:
  # Add return value desc to docmodule above
  # write tests

  alias Tina.Alpaca

  @endpoint "account"

  @type t :: %__MODULE__{
          account_blocked: boolean,
          account_number: String.t(),
          buying_power: String.t(),
          cash: String.t(),
          created_at: String.t(),
          currency: String.t(),
          daytrade_count: integer,
          daytrading_buying_power: String.t(),
          equity: String.t(),
          id: String.t(),
          initial_margin: String.t(),
          last_equity: String.t(),
          last_maintenance_margin: String.t(),
          long_market_value: String.t(),
          maintenance_margin: String.t(),
          multiplier: String.t(),
          pattern_day_trader: boolean,
          portfolio_value: String.t(),
          regt_buying_power: String.t(),
          short_market_value: String.t(),
          shorting_enabled: boolean,
          sma: String.t(),
          status: String.t(),
          trade_suspended_by_user: boolean,
          trading_blocked: boolean,
          transfers_blocked: boolean
        }

  defstruct [
    :account_blocked,
    :account_number,
    :buying_power,
    :cash,
    :created_at,
    :currency,
    :daytrade_count,
    :daytrading_buying_power,
    :equity,
    :id,
    :initial_margin,
    :last_equity,
    :last_maintenance_margin,
    :long_market_value,
    :maintenance_margin,
    :multiplier,
    :pattern_day_trader,
    :portfolio_value,
    :regt_buying_power,
    :short_market_value,
    :shorting_enabled,
    :sma,
    :status,
    :trade_suspended_by_user,
    :trading_blocked,
    :transfers_blocked
  ]

  @doc """
  `get/0` returns all Account Info.
  """
  @spec get() :: tuple()
  def get() do
    Alpaca.get_data(@endpoint, struct(Tina.Account))
  end
end
