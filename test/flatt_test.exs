defmodule KGB.FlattTest do
  use ExUnit.Case, async: true

  test "flatten empty" do
    assert Flatt.flatten([[], []]) == []
  end
end
