defmodule BlackmoreTest do
  use ExUnit.Case
  doctest Blackmore

  test "greets the world" do
    assert Blackmore.hello() == :world
  end
end
