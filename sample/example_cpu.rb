require "droid/monitor/cpu"
require "clockwork"

module Clockwork
  @cpu = Droid::Monitor::Cpu.new( { package: "com.android.chrome" } )
  @time = 0
  @data_file = "sample.txt"

  every(0.5.seconds, "capture cpu usage") do
    @cpu.store_dumped_cpu_usage
    @time += 1

    if @time == 40
      @cpu.save_cpu_usage_as_google_api(@data_file)
      graph_opts = { title: "Example", header1: "this graph is just sample"}
      @cpu.create_graph(@data_file, graph_opts, "result.html")
      @cpu.clear_cpu_usage
      puts "saved"
    end
  end
end