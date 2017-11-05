# defmodule BasicBench do
#   use Benchfella
#
# # @path "../test/files/working/2017-04-29.fit"
#   @path "test/files/not_working/2017-07-30-085002-ELEMNT BOLT FE0B-12-0.fit"
#
#   bench "read" do
#     Fit.read @path
#   end
# end


path = "test/files/working/2017-04-29.fit"
# path = "test/files/not_working/2017-07-30-085002-ELEMNT BOLT FE0B-12-0.fit"
# path = "test/files/working/2016-08-27-12-24-19.fit"

Benchee.run(%{
  "single_run"    => fn -> Fit.read(path) end,
})
