defmodule KGBTest do
  use ExUnit.Case
  doctest KGB

  test "greets the world" do
    assert KGB.hello() == :world
  end
end
