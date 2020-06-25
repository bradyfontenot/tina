defmodule Tina.Position do
  @endpoint "positions"

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

  def get_open_positions() do
    Alpaca.get_data(@endpoint, struct(Tina.Position))
  end

  def get_position_by_symbol(symbol) do
    path = "#{@endpoint}/#{symbol}"
    Alpaca.get_data(path, struct(Tina.Position))
  end

  def close_all_positions() do
    Alpaca.delete_data(@endpoint)
  end

  def close_position_by_symbol(symbol) do
    path = "#{@endpoint}/#{symbol}"
    Alpaca.delete(path)
  end
end
