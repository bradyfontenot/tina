defmodule Tina.Watchlist do
  @moduledoc """
  Provides CRUD operation for the account’s watchlist.
  An account can have multiple watchlists and each is uniquely
  identified by id but can also be addressed by user-defined name.
  Each watchlist is an ordered list of assets.

  Available functions:
  `list/0`
  `get_by_id/1`
  `create/1`
  `update/2`
  `add_asset/2`
  `delete_asset/2`
  `delete/1`

  Alpaca Markets Watchlist Documentation:
  https://alpaca.markets/docs/api-documentation/api-v2/watchlist/
  """

  # TODO for initial release:
  # Can create/* be consolidated?
  # Add return value desc to docmodule above
  # write tests
  # add typescec for struct

  alias Tina.Alpaca

  @endpoint "watchlists"

  @type t :: %__MODULE__{
          account_id: String.t(),
          assets: list(map()),
          created_at: String.t(),
          id: String.t(),
          name: String.t(),
          updated_at: String.t()
        }

  defstruct [
    :account_id,
    :assets,
    :created_at,
    :id,
    :name,
    :updated_at
  ]

  @doc """
  `list/0 returns all orders.
  """
  @spec list() :: tuple()
  def list() do
    Alpaca.get_data(@endpoint, struct(Tina.Watchlist))
  end

  @doc """
  `get_by_id/1` returns watchlist matching supplied watchlist id
  """
  @spec get_by_id(String.t()) :: tuple()
  def get_by_id(id) do
    path = "#{@endpoint}/#{id}"
    Alpaca.get_data(path, struct(Tina.Watchlist))
  end

  @doc """
  `create/1 creates a new watchlist and returns the newly created watchlist
  """
  @spec create(map()) :: tuple()
  def create(params = %{name: _, symbols: _}) do
    Alpaca.post_data(@endpoint, params, struct(Tina.Watchlist))
  end

  @doc """
  `create/1 creates a new watchlist and returns the newly created watchlist
  """
  @spec create(map()) :: tuple()
  def create(params = %{name: _}) do
    Alpaca.post_data(@endpoint, params, struct(Tina.Watchlist))
  end

  @doc """
  `create/1` creates a new watchlist and returns the newly created watchlist
  """
  @spec create(any()) :: tuple()
  def create(_) do
    {:error, "invalid arguments"}
  end

  @doc """
  `updatee/1` creates a new watchlist and returns the newly created watchlist
  """
  @spec update(String.t(), map()) :: tuple()
  def update(id, params = %{name: _, symbols: _}) do
    path = "#{@endpoint}/#{id}"
    Alpaca.put_data(path, params, struct(Tina.Watchlist))
  end

  @spec update(String.t(), map()) :: tuple()
  def update(id, params = %{name: _}) do
    path = "#{@endpoint}/#{id}"
    Alpaca.put_data(path, params, struct(Tina.Watchlist))
  end

  @spec update(any(), any()) :: tuple()
  def update(_, _) do
    {:error, "invalid arguments"}
  end

  @doc """
  `add_asset/1` adds the supplied symbol to the specified watchlist
  and returns the updated list
  """
  @spec add_asset(String.t(), map()) :: tuple()
  def add_asset(watchlist_id, symbol) do
    path = "#{@endpoint}/#{watchlist_id}"
    params = %{symbol: symbol}
    Alpaca.post_data(path, params, struct(Tina.Watchlist))
  end

  @doc """
  `delete_asset/1` removes the supplied symbol from the specified watchlist
  """
  @spec delete_asset(String.t(), map()) :: tuple()
  def delete_asset(id, symbol) do
    path = "#{@endpoint}/#{id}/#{symbol}"
    Alpaca.delete_data(path)
  end

  @doc """
  `delete/1` removes the supplied symbol from the specified watchlist
  """
  @spec delete(String.t()) :: tuple()
  def delete(id) do
    path = "#{@endpoint}/#{id}"
    Alpaca.delete_data(path)
  end
end
