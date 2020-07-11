defmodule Tina.Position do
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
    accepts symbol or asset_id
  """
  @spec get_by_symbol(String.t()) :: tuple()
  def get_by_symbol(symbol) do
    path = "#{@endpoint}/#{symbol}"
    Alpaca.get_data(path, struct(Tina.Position))
  end

  @spec close_all() :: tuple()
  def close_all() do
    Alpaca.delete_data(@endpoint, struct(Order))
  end

  @spec close_by_symbol(Strint.t()) :: tuple()
  def close_by_symbol(symbol) do
    path = "#{@endpoint}/#{symbol}"
    Alpaca.delete(path)
  end
end
