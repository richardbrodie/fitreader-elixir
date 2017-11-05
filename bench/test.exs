defmodule TestOne do
  @abc %{one: 1, two: 2}

  def get do
    @abc
  end
end

res = TestOne.get
IO.inspect res[:one]
