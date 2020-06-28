defmodule Tina.Account do
  use Tesla
  alias Tina.Alpaca

  @account_endpoint "account"
  @activity_endpoint "account/activities"
  @config_endpoint "account/configuration"

  @doc """
  Account struct matches k,v from /account endpoint
  """
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

  defmodule TradeActivity do
    @doc """
     TradeActivity struct matches json object structure returned
     from /account/activity_type endpoint for TradeActivity types.
    """
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

    @type t :: %Tina.Account.TradeActivity{
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
  end

  defmodule NonTradeActivity do
    @doc """
     NonTradeActivity struct matches json object structure returned
     from /account/activity_type endpoint for NonTradeActivity types.
    """
    defstruct [
      :activity_type,
      :id,
      :date,
      :net_amount,
      :symbol,
      :qty,
      :per_share_amount
    ]

    @type t :: %Tina.Account.NonTradeActivity{
            activity_type: String.t(),
            id: String.t(),
            date: String.t(),
            net_amount: String.t(),
            symbol: String.t(),
            qty: String.t(),
            per_share_amount: String.t()
          }
  end

  defmodule Config do
    defstruct [
      :dtpb_check,
      :no_shorting,
      :suspend_trade,
      :trade_confirm_email
    ]
  end

  defmodule PortfolioHistory do
    defstruct [
      :timestamp,
      :equity,
      :profit_loss,
      :profit_loss_pct,
      :base_value,
      :timeframe
    ]
  end

  def get_account() do
    Alpaca.get_data(@account_endpoint, struct(Tina.Account))
  end

  def get_all_activity() do
    Alpaca.get_data(@activity_endpoint)
  end

  @doc """
    retrieving a single activity type: activity_type = "activity"
    retrieving multiple types in one call:  activity_type = "type1, type2, type3, ..."
  """
  def get_activity(activity_type) do
    Alpaca.get_data(@activity_endpoint, activity_type: activity_type)
  end
end
