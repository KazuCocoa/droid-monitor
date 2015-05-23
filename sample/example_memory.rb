require "../lib/droid/monitor/memory"
require "clockwork"

module Clockwork
  @memory = Droid::Monitor::Memory.new( { package: "com.android.chrome" } )
  @time = 0
  @data_file = "sample.txt"

  every(0.5.seconds, "capture memory usage") do
    @memory.store_dumped_memory_details_usage
    @time += 1

    if @time == 40
      @memory.save_memory_details_as_google_api(@data_file)
      graph_opts = { title: "Example", header1: "this graph is just sample"}
      @memory.create_graph(@data_file, graph_opts, "result.html")
      @memory.clear_memory_detail_usage
      puts "saved"
    end
  end
end