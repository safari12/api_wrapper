defmodule Test.Wrapper do
  use API.Wrapper,
    wrappers: [%{
      name: :list_markets,
      endpoint: "/markets",
      method: :get
    }, %{
      name: :order_book,
      endpoint: "/orders",
      method: :get,
      path_query: :market
    }]

  plug Tesla.Middleware.BaseUrl, "https://example.com"
  plug Tesla.Middleware.JSON, decode_content_types: ["text/html"]
end
