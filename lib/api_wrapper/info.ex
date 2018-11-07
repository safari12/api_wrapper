defmodule API.Wrapper.Info do

  @type t :: %__MODULE__{
    name: atom(),
    endpoint: String.t,
    method: atom(),
    data: nil | Map.t,
    query: nil | Map.t,
    path_query: nil | Map.t
  }

  defstruct [
    :name,
    :endpoint,
    :method,
    :data,
    :query,
    :path_query
  ]

  def func_ast_args(nil), do: []
  def func_ast_args(%{query: query}), do: func_ast_args(query)
  def func_ast_args(%{path_query: pq}), do: func_ast_args(pq)
  def func_ast_args(%{data: data}), do: func_ast_args(data)
  def func_ast_args(wrapper) when is_map(wrapper), do: []
  def func_ast_args(arg) when is_atom(arg), do: func_ast_args([arg])
  def func_ast_args(args) when is_list(args) do
    args |> Enum.map(&{&1, [], Elixir})
  end

  def func_name(%{name: name}), do: name

  def url(%{method: :get, endpoint: en, path_query: _}, [pqv]) do
    en <> "/#{pqv}"
  end

  def url(
    %__MODULE__{method: :get, endpoint: en, query: query_keys},
    query_values
  ) when is_list(query_keys) and is_list(query_values) do
    query = Enum.zip(query_keys, query_values)
    |> Enum.into(%{})
    |> URI.encode_query

    en <> "?#{query}"
  end

  def wrapper_url(%{method: :get, endpoint: en}, []), do: en

  def wrapper_url(
    %{method: :post, endpoint: en, data: data_keys},
    data_values
  ) when is_list(data_keys) and is_list(data_values) do

  end

end
