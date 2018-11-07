defmodule API.Wrapper.Sample do
  use API.Wrapper,
    wrappers: [%{
      name: :hello_world,
      endpoint: "/hello_world",
      method: :get
    }, %{
      name: :yo_world,
      endpoint: "/yo_world",
      method: :get,
      path_query: :market
    }]

  plug Tesla.Middleware.BaseUrl, "https://example.com"
  plug Tesla.Middleware.JSON, decode_content_types: ["text/html"]
end
