defmodule TinaTest do
  use ExUnit.Case
  doctest Tina

  test "greets the world" do
    assert Tina.hello() == :world
  end
end
