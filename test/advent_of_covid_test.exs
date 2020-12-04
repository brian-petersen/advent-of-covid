defmodule AdventOfCovidTest do
  use ExUnit.Case
  doctest AdventOfCovid

  test "greets the world" do
    assert AdventOfCovid.hello() == :world
  end
end
