defmodule Tina.Order do
  @moduledoc """
  Offers a variety of functions for interacting with the Order enpdoint.
  Can be used to retrieve, filter, submit, replace, and cancel orders.

  Available functions:
  `list/0`
  `get_open/0`
  `get_closed/0`
  `get_by_order_id/1`
  `get_by_client_id/1`
  `filtered_by/1`
  `submit/1`
  `replace/2`
  `cancel/1`
  `cancel_all/0`

  Alpaca Markets Orders Documentation:
  https://alpaca.markets/docs/api-documentation/api-v2/orders/
  """

  # TODO for initial release:
  # Add return value desc to docmodule above
  # write tests
  # add typescec for struct
  # confirm and define returns in docs for all funcs(especially cancel/cancel_all)

  alias Tina.Alpaca

  @endpoint "orders"

  defstruct [
    :asset_class,
    :asset_id,
    :canceled_at,
    :client_order_id,
    :created_at,
    :expired_at,
    :extended_hours,
    :failed_at,
    :filled_at,
    :filled_avg_price,
    :filled_qty,
    :id,
    :legs,
    :limit_price,
    :order_class,
    :order_type,
    :qty,
    :replaced_at,
    :replaced_by,
    :replaces,
    :side,
    :status,
    :stop_price,
    :submitted_at,
    :symbol,
    :time_in_force,
    :type,
    :updated_at
  ]

  @doc """
  `list/0` returns all orders.
  """
  @spec list() :: tuple()
  def list() do
    Alpaca.get_data(@endpoint, [status: "all"], struct(Tina.Order))
  end

  @doc """
  `get_open/0` returns all open orders
  """
  @spec get_open() :: tuple()
  def get_open() do
    Alpaca.get_data(@endpoint, [status: "open"], struct(Tina.Order))
  end

  @doc """
  get_closed/0 returns all closed orders
  """
  @spec get_closed() :: tuple()
  def get_closed() do
    Alpaca.get_data(@endpoint, [status: "closed"], struct(Tina.Order))
  end

  @doc """
  `get_by_order_id/1` returns order matching supplied order id.
  """
  @spec get_by_order_id(String.t()) :: tuple()
  def get_by_order_id(order_id) do
    path = "#{@endpoint}/#{order_id}"
    Alpaca.get_data(path, struct(Tina.Order))
  end

  @doc """
  `get_by_client_id/1` returns order matching supplied client id.
  """
  @spec get_by_client_id(String.t()) :: tuple()
  def get_by_client_id(client_id) do
    Alpaca.get_data(@endpoint, [by_client_order_id: client_id], struct(Tina.Order))
  end

  @doc """
  `filtered_by returns/1` orders matching supplied query params
  query must be suplied as keyword list

  valid params:
  `:status` <string>
  `:limit` <int>
  `::after` <timestamp>
  `:until` <timestamp>
  `:direction` <string>
  `:nested` <boolean>
  """
  @spec filtered_by([key: any()]) :: tuple()
  def filtered_by(query) do
    Alpaca.get_data(@endpoint, query, struct(Tina.Order))
  end

  @typedoc """
  see Alpaca Documentation for required, optional, and dependent params
  for order submission.
  https://alpaca.markets/docs/api-documentation/api-v2/orders/

  You do not need to pass a map w/ all parameters shown in the typespec. Order will succeed
  with minimum required params, and requisite dependent params. If unsuccessful
  function will return {:error, %{msg: string, status: int}} where msg is the reason for
  order failure and status is the http code.
  """

  @type order_params :: %{
          symbol: String.t(),
          qty: integer(),
          side: String.t(),
          type: String.t(),
          time_in_force: String.t(),
          limit_price: float(),
          stop_price: float() | nil,
          extended_hours: boolean(),
          client_order_id: String.t() | nil,
          order_class: String.t() | nil,
          take_profit: map(),
          stop_loss: map()
        }

  @doc """
  `submit/1` submits an order and returns tuple with struct of submitted order
  """
  @spec submit(order_params()) :: tuple()
  def submit(order_params) do
    Alpaca.post_data(@endpoint, order_params, struct(Tina.Order))
  end

  @doc """
  `replace/2` cancels the current order and resubmits it with updated params
  returns tuple w/ a struct of new order.
  """
  @spec replace(String.t(), order_params()) :: tuple()
  def replace(id, order_params) do
    path = "#{@endpoint}/#{id}"
    Alpaca.patch_data(path, order_params, struct(Tina.Order))
  end

  @doc """
  `cancel/1` cancels order matching supplied order id.
  """
  @spec cancel(String.t()) :: tuple()
  def cancel(id) do
    path = "#{@endpoint}/#{id}"
    Alpaca.delete_data(path)
  end

  @doc """
  `cancel_all/0` cancels all open orders
  """
  @spec cancel_all() :: tuple()
  def cancel_all() do
    Alpaca.delete_data(@endpoint)
  end
end
