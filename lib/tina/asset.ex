defmodule Tina.Asset do
  @moduledoc """
Serves as the master list of assets available for trade and data consumption
from Alpaca. Assets are sorted by asset class, exchange and symbol.
Some assets are only available for data consumption via Polygon,
and are not tradable with Alpaca. These assets will be marked with the
flag tradable=false

Available functions:
  `list/0`
  `filtered_by/1`
  `get_by_id/1`
  `get_by_symbol/1`

  Alpaca Markets Assets Documentation:
  https://alpaca.markets/docs/api-documentation/api-v2/assets/
  """

  # TODO for initial release:
  # Add return value desc to docmodule above
  # write tests

  alias Tina.Alpaca

  @endpoint "assets"

  @type t :: %__MODULE__{
          id: String.t(),
          class: String.t(),
          exchange: String.t(),
          symbol: String.t(),
          status: String.t(),
          tradable: boolean(),
          marginable: boolean(),
          shortable: boolean(),
          easy_to_borrow: boolean()
        }

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

  @doc """
  `list/0` returns all assets.
  """
  @spec list() :: tuple()
  def list() do
    Alpaca.get_data(@endpoint, struct(Tina.Asset))
  end

  @doc """
  `get_by_id/1` returns all assets for given asset id.
  """
  @spec get_by_id(String.t()) :: tuple()
  def get_by_id(id) do
    path = "#{@endpoint}/#{id}"
    Alpaca.get_data(path, struct(Tina.Asset))
  end

  @doc """
  `get_by_symbol/1` returns all assets for given symbol.
  """
  @spec get_by_symbol(String.t()) :: tuple()
  def get_by_symbol(symbol) do
    path = "#{@endpoint}/#{symbol}"
    Alpaca.get_data(path, struct(Tina.Asset))
  end

  @doc """
  `filtered_by/1` returns assets filtered by status and/or class type.
  query_params supplied as keyword list.

  valid keywords:
  `:status` <string>
  `:asset_class` <string>
  """
  @spec filtered_by(key: String.t()) :: tuple()
  def filtered_by(query) do
    Alpaca.get_data(@endpoint, query, struct(Tina.Asset))
  end
end
