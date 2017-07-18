defmodule FitTest do
  use ExUnit.Case
  doctest Fit

  test "read working files" do
    # path = "test/files/2016-04-09-13-19-18.fit"
    # {:ok, _pid} = Fit.read(path)
    path = "test/files/working/1471568492.fit"
    {:ok, _pid} = Fit.read(path)
  end
  #
  # test "read not working file" do
  #   path = "test/files/2016-02-08-23-38-56.fit"
  #   {:ok, _pid} = Fit.read(path)
  # end

  test "read all working files" do
    Path.wildcard("test/files/working/*.fit")
    |> Enum.each(fn p -> IO.puts(p); Fit.read(p) end)
  end

  test "read all not_working files" do
    Path.wildcard("test/files/not_working/*.fit")
    |> Enum.each(fn p -> IO.puts(p); Fit.read(p) end)
  end

  test "read all unknown files" do
    Path.wildcard("test/files/*.fit")
    |> Enum.each(fn p -> IO.puts(p); Fit.read(p) end)
  end
end
