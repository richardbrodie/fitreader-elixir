defmodule FitTest do
  use ExUnit.Case
  doctest Fit

  test "read working garmin file" do
    path = "test/files/working_garmin.fit"
    IO.puts path
    {:ok, pid} = Fit.read(path)
    result = Fit.record(pid, 18)
    # IO.inspect result
  end

  test "read working wahoo file" do
    path = "test/files/working_wahoo.fit"
    IO.puts path
    {:ok, pid} = Fit.read(path)
    result = Fit.record(pid, 18)
    # IO.inspect result
  end

  test "read working wahoo with dev fields" do
    path = "test/files/working_wahoo_dev_fields.fit"
    IO.puts path
    {:ok, pid} = Fit.read(path)
    result = Fit.record(pid, 18)
    # IO.inspect result
  end

  test "read all working files" do
    Path.wildcard("test/files/working/*.fit")
    |> Enum.each(fn p ->
      IO.puts p
      {:ok, pid} = Fit.read(p)
      result = Fit.record(pid, 18)
      # IO.inspect result
    end)
  end

  test "read all working wahoo files" do
    Path.wildcard("test/files/wahoo/*.fit")
    |> Enum.each(fn p ->
      IO.puts p
      {:ok, pid} = Fit.read(p)
      result = Fit.record(pid, 18)
      # IO.inspect result
    end)
  end
end
