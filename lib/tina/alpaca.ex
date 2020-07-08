defmodule Tina.Alpaca do
  use Tesla
  alias Tina.Helpers

  @apca_api_key_id Application.get_env(:tina, :apca_api_key_id)
  @apca_api_secret_key Application.get_env(:tina, :apca_api_secret_key)
  @apca_api_base_url Application.get_env(:tina, :apca_api_base_url)
  @apca_api_data_url Application.get_env(:tina, :apca_api_data_url)

  plug(Tesla.Middleware.BaseUrl, extract_key(@apca_api_base_url))

  plug(Tesla.Middleware.Headers, [
    {"APCA-API-KEY-ID", extract_key(@apca_api_key_id)},
    {"APCA-API-SECRET-KEY", extract_key(@apca_api_secret_key)}
  ])

  plug(Tesla.Middleware.JSON, decode: &Jason.decode/1, engine_opts: [keys: :atoms])

  @spec extract_key(:atom) :: :atom
  defp extract_key(key), do: key

  # Temporary for inspecting response objects / debugging
  # def get_data(endpoint) do
  #   get(endpoint)
  # end

  @spec get_data(:atom, struct()) :: tuple()
  def get_data(endpoint, struct) do
    get(endpoint)
    |> validate()
    |> format_output(struct)
  end

  @spec get_data(:atom, [key: any()], struct()) :: tuple()
  def get_data(endpoint, query_params, struct) do
    get(endpoint, query: query_params)
    |> validate()
    |> format_output(struct)
  end

  @spec get_data_by_id(:atom, struct()) :: tuple()
  def get_data_by_id(endpoint, struct) do
    get(endpoint)
    |> validate()
    |> format_output(struct)
  end

  @spec post_data(:atom, map(), struct()) :: tuple()
  def post_data(endpoint, body, struct) do
    # Temporary inspection
    IO.inspect(post(endpoint, body))
    |> validate()
    |> format_output(struct)
  end

  # def post_data(endpoint, body, query_params)

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
    |> validate()

    # |> format_output(struct)
  end

  @spec delete_data(:atom, struct()) :: tuple()
  def delete_data(endpoint, struct) when is_struct(struct) do
    delete(endpoint)
    |> validate()
    |> format_output(struct)
  end

  @spec delete_data(:atom, map()) :: tuple()
  def delete_data(endpoint, body) when is_map(body) do
    delete(endpoint, body)
    |> validate()
  end

  @spec validate(tuple()) :: tuple()
  defp validate(response) do
    {_, env} = response
    status = env.status
    # Temporary Inspection
    IO.inspect(env)

    case response do
      # TO Be REMOVED - temp for development
      # {:ok, %{status: 200}} = {:ok, response}  when status in 200..399 ->
      {:ok, response} when status in 200..399 ->
        {:ok, response}

      {:ok, %{status: status}} ->
        msg = env.body["message"]
        {:error, %{status: status, msg: msg}}

      {:error, reason} ->
        {:error, reason}
    end
  end

  @spec format_output(tuple(), struct()) :: tuple()
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
