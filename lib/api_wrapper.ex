defmodule API.Wrapper do
  defmacro __using__(options) do
    quote do
      use Tesla
      import API.Wrapper

      IO.inspect unquote(options[:wrappers])
      |> Enum.each(&generate_wrapper_func/1)
    end
  end

  def wrapper_func_args(nil), do: []
  def wrapper_func_args(%{query: query}), do: wrapper_func_args(query)
  def wrapper_func_args(%{path_query: pq}), do: wrapper_func_args(pq)
  def wrapper_func_args(%{data: data}), do: wrapper_func_args(data)
  def wrapper_func_args(wrapper) when is_map(wrapper), do: []
  def wrapper_func_args(arg) when is_atom(arg), do: wrapper_func_args([arg])
  def wrapper_func_args(args) when is_list(args) do
    args |> Enum.map(&{&1, [], Elixir})
  end

  def wrapper_func_name(%{name: name}), do: name

  def wrapper_url(%{method: :get, endpoint: en, path_query: _}, [pqv]) do
    en <> "/#{pqv}"
  end

  def wrapper_url(
    %{method: :get, endpoint: en, query: query_keys},
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

  defmacro generate_wrapper_func(wrapper) do
    quote bind_quoted: [wrapper: wrapper] do
      func_args = wrapper_func_args(wrapper)
      func_name = wrapper_func_name(wrapper)
      def unquote(func_name)(unquote_splicing(func_args)) do
        wrapper_url(unquote(Macro.escape(wrapper)), unquote(func_args))
        |> api_call
      end
    end
  end

  defmacro api_call(url) do
    quote do
      unquote(url) |> get
    end
  end
end
