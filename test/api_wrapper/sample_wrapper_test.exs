defmodule API.Wrapper.SampleTest do
  use ExUnit.Case
  
  describe "did generate the following functions" do
    test "hello_world" do
      assert Kernel.function_exported?(API.Wrapper.Sample, :hello_world, 0)
    end

    test "yo_world" do
      assert Kernel.function_exported?(API.Wrapper.Sample, :yo_world, 1)
    end
  end
end
