defmodule Tina.Watchlist do
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

  @spec list_all() :: tuple()
  def list_all() do
    Alpaca.get_data(@endpoint, struct(Tina.Watchlist))
  end

  @spec get_by_id(String.t()) :: tuple()
  def get_by_id(id) do
    path = "#{@endpoint}/#{id}"
    Alpaca.get_data(path, struct(Tina.Watchlist))
  end

  @spec create(map()) :: tuple()
  def create(params = %{name: _, symbols: _}) do
    Alpaca.post_data(@endpoint, params, struct(Tina.Watchlist))
  end

  @spec create(map()) :: tuple()
  def create(params = %{name: _}) do
    Alpaca.post_data(@endpoint, params, struct(Tina.Watchlist))
  end

  @spec create(any()) :: tuple()
  def create(_) do
    {:error, "invalid arguments"}
  end

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

  @spec add_asset(String.t(), map()) :: tuple()
  def add_asset(watchlist_id, symbol) do
    path = "#{@endpoint}/#{watchlist_id}"
    params = %{symbol: symbol}
    Alpaca.post_data(path, params, struct(Tina.Watchlist))
  end

  @spec delete_asset(String.t(), map()) :: tuple()
  def delete_asset(id, symbol) do
    path = "#{@endpoint}/#{id}/#{symbol}"
    Alpaca.delete_data(path)
  end

  @spec delete_list(String.t()) :: tuple()
  def delete_list(id) do
    path = "#{@endpoint}/#{id}"
    Alpaca.delete_data(path)
  end
end
