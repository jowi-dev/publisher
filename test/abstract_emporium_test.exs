defmodule AbstractEmporiumTest do
  use ExUnit.Case
  doctest AbstractEmporium

  test "greets the world" do
    assert AbstractEmporium.hello() == :world
  end
end
