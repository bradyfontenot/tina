defmodule Tina.Alpaca do
  use Tesla
  alias Tina.Helpers

  @apca_api_key_id Application.get_env(:tina, :apca_api_key_id)
  @apca_api_secret_key Application.get_env(:tina, :apca_api_secret_key)
  @apca_api_base_url Application.get_env(:tina, :apca_api_base_url)

  plug(Tesla.Middleware.BaseUrl, extract_key(@apca_api_base_url))

  plug(Tesla.Middleware.Headers, [
    {"APCA-API-KEY-ID", extract_key(@apca_api_key_id)},
    {"APCA-API-SECRET-KEY", extract_key(@apca_api_secret_key)}
  ])

  plug(Tesla.Middleware.JSON, decode: &Jason.decode/1, engine_opts: [keys: :atoms])

  defp extract_key(key), do: key

  def get_data(endpoint, struct) do
    get(endpoint)
    |> validate()
    |> format_output(struct)
  end

  def get_data(endpoint, query_params, struct) do
    get(endpoint, query: query_params)
    |> validate()
    |> format_output(struct)
  end

  def get_data_by_id(endpoint, struct) do
    get(endpoint)
    |> validate()
    |> format_output(struct)
  end

  ####### TODO #########
  # finish / check functionality
  def post_data(endpoint, body) do
    post(endpoint, body)
    |> validate()
  end

  def put_data(endoint, body, struct) do
    put(endoint, body)
    |> validate()
    |> format_output(struct)
  end

  @spec patch_data(:atom, map(), struct()) :: tuple()
  def patch_data(endpoint, body, struct) do
    patch(endpoint, body)
    |> validate()
    |> format_output(struct)
  end

  def delete_data(endpoint) do
    delete(endpoint)
  end

  ####### TODO #########
  # finish / check functionality
  def delete_data(endpoint, body) do
    delete(endpoint, body)
  end

  # def post_data(endpoint, body, query_params)

  defp validate(response) do
    case response do
      {:ok, %{status: 200}} = {:ok, response} ->
        {:ok, response}

      {:ok, %{status: status}} ->
        {:error, status}

      {:error, reason} ->
        {:error, reason}
    end
  end

  defp format_output({:ok, _response} = {:ok, response}, struct) do
    case is_map(response.body) do
      true ->
        data = Helpers.to_struct(response.body, struct)

        {:ok, data}

      false ->
        data =
          Enum.into(response.body, [], fn item ->
            Helpers.to_struct(item, struct)
          end)

        {:ok, data}
    end
  end

  @spec format_output(tuple(), struct()) :: tuple()
  defp format_output({:error, _status} = {:error, status}, _struct) do
    {:error, status}
  end
end
