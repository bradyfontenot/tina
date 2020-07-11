defmodule Tina.Account.Configuration do
  @moduledoc """
  Returns timeseries data about equity and profit/loss
  of the account in requested timespan

  Available functions:
  list/0
  filtered_by/1

  Alpaca Markets Account Configuration Documentation:
  https://alpaca.markets/docs/api-documentation/api-v2/account-configuration
  """

  # TODO for initial release:
  # Add return value desc to docmodule above
  # write tests

  alias Tina.Alpaca

  @endpoint "account/configurations"

  @type t :: %__MODULE__{
          dtbp_check: String.t(),
          no_shorting: boolean(),
          suspend_trade: boolean(),
          trade_confirm_email: String.t(),
          # not documented in Alpaca docs
          pdt_check: String.t()
        }

  defstruct [
    :dtbp_check,
    :no_shorting,
    :suspend_trade,
    :trade_confirm_email,
    :pdt_check
  ]

  @spec get_config() :: tuple()
  def get_config() do
    Alpaca.get_data(@endpoint, struct(Config))
  end

  @doc """
    params supplied as map
  """
  @spec update_config(map()) :: tuple()
  def update_config(params) do
    Alpaca.patch_data(@endpoint, params, struct(Config))
  end
end
