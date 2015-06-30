require_relative "../lib/droid/monitor/net"
require "clockwork"

module Clockwork
  @net = Droid::Monitor::Net.new( { package: "com.android.chrome" } )
  @time = 0
  @data_file = "sample.txt"
  @data_file2 = "sample2.txt"

  every(0.5.seconds, "capture nets usage") do
    @net.store_dumped_tcp_rcv
    @net.store_dumped_tcp_snd
    @time += 1

    if @time == 40
      @net.save_cpu_usage_as_google_api_rec(@data_file)
      @net.save_cpu_usage_as_google_api_snd(@data_file2)
      graph_opts = { title: "Example", header1: "this graph is just sample"}
      @net.create_graph(@data_file, graph_opts, "result.html")
      @net.create_graph(@data_file2, graph_opts, "result2.html")

      @net.clear_tcps
      puts "saved"
    end
  end
end
