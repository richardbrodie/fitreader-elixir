defmodule FitTest do
  use ExUnit.Case
  doctest Fit

  test "read working garmin files" do
    path = "test/files/working/1471568492.fit"
    {:ok, pid} = Fit.read(path)
    res = Fit.digest(pid)
    IO.inspect res
    # IO.inspect Enum.at(res, 1)
  end
  # test "read working garmin files" do
  #   path = "test/files/working/1471568492.fit"
  #   [path]
  #   |> Enum.map(fn p -> Fit.read(p) end)
  #   |> Enum.each(fn {:ok, f} -> Fit.record(f, 20) end)
  # end

  test "read working wahoo files" do
    path = "test/files/wahoo/2017-05-10-060659-ELEMNT BOLT FE0B-2-0.fit"
    [path]
    |> Enum.each(fn p ->
      IO.puts p
      {:ok, pid} = Fit.read(p)
      result = Fit.record(pid, 18)
      IO.inspect result
      _records = Fit.record(pid, 20)
    end)
  end

  test "read all not working files" do
    Path.wildcard("test/files/not_working/*.fit")
    |> Enum.each(fn p ->
      IO.puts p
      {:ok, pid} = Fit.read(p)
      r = Fit.record(pid, 20)
      # r = Fit.record(pid, 23)
      IO.inspect r
    end)
  end

  test "read all working files" do
    Path.wildcard("test/files/working/*.fit")
    |> Enum.each(fn p ->
      IO.puts p
      {:ok, pid} = Fit.read(p)
      Fit.record(pid, 20)
    end)
  end

  test "read all wahoo files" do
    Path.wildcard("test/files/wahoo/*.fit")
    |> Enum.each(fn p ->
      IO.puts p
      {:ok, pid} = Fit.read(p)
      Fit.record(pid, 20)
    end)
  end
end
