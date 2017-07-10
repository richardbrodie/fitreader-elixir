defmodule FitTest do
  use ExUnit.Case
  doctest Fit

  test "read a file" do
    assert Fit.read == [0, 2, 3, 7, 12, 13, 18, 19, 20, 21, 22, 23, 34, 49, 79, 104, 113, 140, 142, 147]
  end
end
