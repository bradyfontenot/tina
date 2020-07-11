defmodule Tina.Position do
  @moduledoc """
  Provides information about an account’s current open positions.
  which will be updated live as price information is updated.
  Once a position is closed, it will no longer be queryable through this API

  Available functions:
  `get_open/0`
  `get_by_symbol/1`
  `close_by_symbol/1`
  `close_all/0`

  Alpaca Markets Positions Documentation:
  https://alpaca.markets/docs/api-documentation/api-v2/positions/
  """

  # TODO for initial release:
  # Add return value desc to docmodule above
  # write tests
  # add typescec for struct
  # confirm and define returns in docs for all funcs(especially cancel/cancel_all)

  alias Tina.Alpaca
  alias Tina.Order

  @endpoint "positions"

  @type t :: %__MODULE__{
          asset_id: String.t(),
          symbol: String.t(),
          exchange: String.t(),
          asset_class: String.t(),
          avg_entry_price: String.t(),
          qty: String.t(),
          side: String.t(),
          market_value: String.t(),
          cost_basis: String.t(),
          unrealized_pl: String.t(),
          unrealized_plpc: String.t(),
          unrealized_intraday_pl: String.t(),
          unrealized_intraday_plpc: String.t(),
          current_price: String.t(),
          lastday_price: String.t(),
          change_today: String.t()
        }

  defstruct [
    :asset_id,
    :symbol,
    :exchange,
    :asset_class,
    :avg_entry_price,
    :qty,
    :side,
    :market_value,
    :cost_basis,
    :unrealized_pl,
    :unrealized_plpc,
    :unrealized_intraday_pl,
    :unrealized_intraday_plpc,
    :current_price,
    :lastday_price,
    :change_today
  ]

  # TODO:
  # if no open positions return {:ok, none} or similar instead
  # of {:ok, []}
  @spec get_open() :: tuple()
  def get_open() do
    Alpaca.get_data(@endpoint, struct(Tina.Position))
  end

  @doc """
  get_by_symbol/1 returns positions matching supplied symbol
  """
  @spec get_by_symbol(String.t()) :: tuple()
  def get_by_symbol(symbol) do
    path = "#{@endpoint}/#{symbol}"
    Alpaca.get_data(path, struct(Tina.Position))
  end

  @doc """
  get_by_id/1 returns positions matching supplied asset_id
  """
  @spec get_by_id(String.t()) :: tuple()
  def get_by_id(id) do
    path = "#{@endpoint}/#{id}"
    Alpaca.get_data(path, struct(Tina.Position))
  end

  @doc """
  close_by_symbol/1 closes all positions matching supplied symbol
  """
  @spec close_by_symbol(String.t()) :: tuple()
  def close_by_symbol(symbol) do
    path = "#{@endpoint}/#{symbol}"
    Alpaca.delete(path)
  end

  @doc """
  close_by_id/1 closes all positions matching supplied asset id
  """
  @spec close_by_id(String.t()) :: tuple()
  def close_by_id(id) do
    path = "#{@endpoint}/#{id}"
    Alpaca.delete(path)
  end

  @doc """
  close_all/1 closes all positions
  """
  @spec close_all() :: tuple()
  def close_all() do
    Alpaca.delete_data(@endpoint, struct(Order))
  end
end
