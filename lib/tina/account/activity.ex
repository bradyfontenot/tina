defmodule Tina.Account.Activity do
  @moduledoc """
  Provides access to a historical record of transaction activities that have impacted your account.
  Trade execution activities and non-trade activities can be accessed.

  Available functions:
  get/0
  filtered_by_type/1

  Alpaca Markets Account Activities Documentation:
  https://alpaca.markets/docs/api-documentation/api-v2/account-activities
  """

  # TODO for initial release:
  # Make calls work!
  # Add return value desc to docmodule above
  # write tests

  alias Tina.Alpaca

  @endpoint "account/activities"

  defmodule TradeActivity do
    @doc """
    TradeActivity struct matches json object structure returned
    from /account/activity_type endpoint for TradeActivity types.

    """

    @type t :: %__MODULE__{
            activity_type: String.t(),
            id: String.t(),
            cum_qty: String.t(),
            leaves_qty: String.t(),
            price: String.t(),
            qty: String.t(),
            side: String.t(),
            symbol: String.t(),
            transaction_time: String.t(),
            order_id: String.t(),
            type: String.t()
          }

    defstruct [
      :activity_type,
      :id,
      :cum_qty,
      :leaves_qty,
      :price,
      :qty,
      :side,
      :symbol,
      :transaction_time,
      :order_id,
      :type
    ]
  end

  defmodule NonTradeActivity do
    @typedoc """
     NonTradeActivity struct matches json object structure returned
     from /account/activity_type endpoint for NonTradeActivity types.
    """

    @type t :: %__MODULE__{
            activity_type: String.t(),
            id: String.t(),
            date: String.t(),
            net_amount: String.t(),
            symbol: String.t(),
            qty: String.t(),
            per_share_amount: String.t()
          }

    defstruct [
      :activity_type,
      :id,
      :date,
      :net_amount,
      :symbol,
      :qty,
      :per_share_amount
    ]
  end

  @spec get() :: tuple()
  def get() do
    Alpaca.get_data(@endpoint, struct(TradeActivity))
  end

  @doc """
  retrieving a single activity type: activity_type = "activity"
  retrieving multiple types in one call:  activity_type = "type1, type2, type3, ..."
  """
  @spec get() :: tuple()
  def list() do
    Alpaca.get_data(@endpoint, activit_type: "")
  end

  # @spec get_single_type(String.t()) :: tuple()
  def get_by_type(activity_type) do
    Alpaca.get_data(@endpoint, activity_type: activity_type)
  end

  @spec get_multiple_types(list(String.t())) :: tuple()
  def get_multiple_types(query) do
    Alpaca.get_data(@endpoint, query)
  end
end
