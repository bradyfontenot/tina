defmodule Tina.Asset do
  alias Tina.Alpaca

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

  def list_all() do
    Alpaca.get_data(@endpoint, struct(Tina.Asset))
  end

  @doc """
    query_params supplied as keyword list
    valid keywords: :status, :asset_class
  """
  def get_assets_filtered_by(query_params) do
    Alpaca.get_data(@endpoint, query_params, struct(Tina.Asset))
  end

  def get_asset_by_id(id) do
    path = "#{@endpoint}/#{id}"
    Alpaca.get_data(path, struct(Tina.Asset))
  end

  def get_asset_by_symbol(symbol) do
    path = "#{@endpoint}/#{symbol}"
    Alpaca.get_data(path, struct(Tina.Asset))
  end
end
