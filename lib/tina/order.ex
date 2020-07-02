defmodule Tina.Order do
  use Tesla
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

  def list_all() do
    # IO.puts(Alpaca.get_data("oops"))
    Alpaca.get_data(@endpoint, [status: "all"], struct(Tina.Order))
  end

  def get_open() do
    Alpaca.get_data(@endpoint, [status: "open"], struct(Tina.Order))
  end

  def get_closed() do
    Alpaca.get_data(@endpoint, [status: "closed"], struct(Tina.Order))
  end

  def get_orders_filtered_by(query_params) do
    Alpaca.get_data(@endpoint, query_params, struct(Tina.Order))
  end

  def get_order_by_id(order_id) do
    path = "#{@endpoint}/#{order_id}"
    Alpaca.get_data_by_id(path, struct(Tina.Order))
  end

  def get_order_by_client_id(client_id) do
    Alpaca.get_data(@endpoint, [by_client_order_id: client_id], struct(Tina.Order))
  end

  @doc """
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

  @spec submit_order(order_params()) :: {:ok, %Tina.Order{}} | {:error, map()}
  def submit_order(order_params) do
    Alpaca.post_data(@endpoint, order_params, struct(Tina.Order))
  end

  def submit_buy_limit(symbol, qty, time_in_force, limit_price, opts \\ []) do
    body = %{
      side: :buy,
      type: :limit,
      symbol: symbol,
      qty: qty,
      time_in_force: time_in_force,
      limit_price: limit_price,
    }

    Alpaca.post_data(@endpoint, body)
  end

  def submit_sell_limit() do
  end
end
