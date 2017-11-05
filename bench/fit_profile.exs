defmodule SampleRunner do
  import ExProf.Macro

  @doc "analyze with profile macro"
  def do_analyze do
    profile do
      # path = "test/files/working_wahoo_dev_fields.fit"
      path = "test/files/working/2017-04-29.fit"
      {:ok, pid} = Fit.read(path)
      # IO.inspect Fit.record(pid, 18)
      # IO.inspect Fit.digest(pid)
    end
  end

  @doc "get analysis records and sum them up"
  def run do
    records = do_analyze()
    # total_percent = Enum.reduce(records, 0.0, &(&1.percent + &2))
    # IO.inspect "total = #{total_percent}"
  end
end

SampleRunner.run
