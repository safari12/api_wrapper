defmodule API.WrapperTest do
  use ExUnit.Case
  doctest API.Wrapper

  test "greets the world" do
    assert API.Wrapper.hello() == :world
  end
end
