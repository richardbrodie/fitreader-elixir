defmodule FitTest do
  use ExUnit.Case
  doctest Fit

  test "read a file" do
    assert is_pid Fit.read
  end
end
