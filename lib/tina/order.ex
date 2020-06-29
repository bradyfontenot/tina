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
    Options: [extended_hours, client_order_id, order_class, take_profit, stop_loss]
  """
  def submit_custom_order(
        symbol,
        qty,
        side,
        type,
        time_in_force,
        limit_price,
        stop_price,
        opts \\ []
      ) do
        body = %{
          symbol: symbol,
          qty: qty,
          side: side,
          type: type,
          time_in_force: time_in_force,
          limit_price: limit_price,
          stop_price: stop_price,
        }

        Alpaca.post_data(@endpoint, body)
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
