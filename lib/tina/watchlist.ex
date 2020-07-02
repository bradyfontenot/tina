defmodule Tina.Watchlist do
  alias Tina.Alpaca

  @endpoint "watchlists"

  defstruct [
    :account_id,
    :assets,
    :created_at,
    :id,
    :name,
    :updated_at
  ]

  def list_all() do
    Alpaca.get_data(@endpoint, struct(Tina.Watchlist))
  end

  def get_by_id(id) do
    path = "#{@endpoint}/#{id}"
    Alpaca.get_data(path, struct(Tina.Watchlist))
  end

  @spec create(map()) :: struct()
  def create(params = %{name: _, symbols: _}) do
    Alpaca.post_data(@endpoint, params, struct(Tina.Watchlist))
  end

  @spec create(map()) :: struct()
  def create(params = %{name: _}) do
    Alpaca.post_data(@endpoint, params, struct(Tina.Watchlist))
  end

  @spec create(any()) :: tuple()
  def create(_) do
    {:error, "invalid arguments"}
  end

  # @spec update(map()) :: struct()
  def update(id, params = %{name: _, symbols: _}) do
    path = "#{@endpoint}/#{id}"
    Alpaca.put_data(path, params, struct(Tina.Watchlist))
  end

  # @spec update(map()) :: struct()
  def update(id, params = %{name: _}) do
    path = "#{@endpoint}/#{id}"
    Alpaca.put_data(path, params, struct(Tina.Watchlist))
  end

  # @spec update(any()) :: tuple()
  def update(_, _) do
    {:error, "invalid arguments"}
  end

  def add_asset(watchlist_id, symbol) do
    path = "#{@endpoint}/#{watchlist_id}"
    params = %{symbol: symbol}
    Alpaca.post_data(path,params, struct(Tina.Watchlist))
  end

  def delete_list(id) do
    path = "#{@endpoint}/#{id}"
    Alpaca.delete_data(path)
  end

  def delete_asset(id, symbol) do
    path = "#{@endpoint}/#{id}/#{symbol}"
    Alpaca.delete_data(path)
  end
end
