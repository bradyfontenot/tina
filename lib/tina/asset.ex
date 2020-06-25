defmodule Tina.Asset do
  @endpoint "assets"

  defstruct [
    :id,
    :class,
    :exchange,
    :symbol,
    :status,
    :tradable,
    :marginable,
    :shortable,
    :easy_to_borrow
  ]

  def get_assets() do
    Alpaca.get_data(@endpoint, struct(Tina.Assets))
  end

  @doc """
    query_params supplied as keyword list
    valid keywords: :status, :asset_class
  """
  def get_assets_filtered_by(query_params) do
    Alpaca.get_data(@endpoint, query_params, struct(Tina.Assets))
  end

  def get_asset_by_id(id) do
    Alpaca.get_data(@endpoint, [id: id], struct(Tina.Assets))
  end

  def get_asset_by_symbol(symbol) do
    path = "#{@endpoint}/#{symbol}"
    Alpaca.get_data(path, struct(Tina.Assets))
  end
end
