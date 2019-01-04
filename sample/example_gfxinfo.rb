# frozen_string_literal: true

require 'droid/monitor/gfxinfo'
require 'clockwork'

module Clockwork
  @gfx = Droid::Monitor::Gfxinfo.new(package: 'com.android.chrome')
  @time = 0
  @data_file_gfx = 'sample_gfx.txt'
  @data_file_mem = 'sample_mem.txt'
  @data_file_frame = 'sample_frame.txt'

  every(0.5.seconds, 'capture gfxinfo usage') do
    @gfx.store_dumped_gfxinfo_usage
    @time += 1

    if @time == 40
      # Shold set 3 output files to save each data
      @gfx.save_gfxinfo_usage_as_google_api(@data_file_gfx, @data_file_mem, @data_file_frame)
      graph_opts = { title: 'Example', header1: 'this graph is just sample' }
      @gfx.create_graph(@data_file_gfx, graph_opts, 'result_gfx.html')
      @gfx.create_graph(@data_file_mem, graph_opts, 'result_mem.html')
      @gfx.create_graph(@data_file_frame, graph_opts, 'result_frame.html')
      @gfx.clear_gfxinfo_usage
      puts 'saved'
    end
  end
end
