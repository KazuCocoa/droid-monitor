require_relative "../monitor"
require_relative "common/commons"
require_relative "report/google_api_template"

require "json"

module Droid
  module Monitor
    class Gfxinfo < Droid::Monitor::Adb
      attr_reader :gfxinfo_usage

      include Droid::Monitor::Utils

      def initialize(opts = {})
        super(opts)
        @gfxinfo_usage = []
      end

      def clear_gfxinfo_usage
        @gfxinfo_usage = []
      end

      def dump_gfxinfo_usage(dump_data)
        scanned_dump1 = dump_data.scan(/^.*views,.*kB of display lists,.*frames rendered.*$/).map(&:strip).first
        scanned_dump2 = dump_data.scan(/^.*bytes,.*MB.*$/).map(&:strip).first

        return [] if scanned_dump1.nil? || scanned_dump2.nil?

        dump1 = scanned_dump1.split(/\s/).reject(&:empty?)
        dump2 = scanned_dump2.split(/\s/).reject(&:empty?)

        dump1 + dump2
      rescue StandardError => e
        puts e
        []
      end

      # called directory
      def store_dumped_gfxinfo_usage
        self.store_gfxinfo_usage(self.dump_gfxinfo_usage(self.dump_gfxinfo))
      end

      # @param [String] file_path_gfx A file path to save gfx data.
      # @param [String] file_path_mem A file path to save memory usage regarding gfx data.
      # @param [String] file_path_frame A file path to save frame data.
      def save_gfxinfo_usage_as_google_api(file_path_gfx, file_path_mem, file_path_frame)
        self.save(export_as_google_api_format_gfx(@gfxinfo_usage), file_path_gfx)
        self.save(export_as_google_api_format_mem(@gfxinfo_usage), file_path_mem)
        self.save(export_as_google_api_format_frame(@gfxinfo_usage), file_path_frame)
      end

      def store_gfxinfo_usage(dumped_gfxinfo)
        @gfxinfo_usage.push self.merge_current_time(transfer_total_gfxinfo_to_hash(dumped_gfxinfo))
      end

      def transfer_total_gfxinfo_to_hash(dump_gfxinfo_array)
        if dump_gfxinfo_array.length <= 1
          {
            view: 0,
            display_lists_kb: 0,
            frames_rendered: 0,
            total_memory: 0,
            time: dump_gfxinfo_array.last,
          }
        else
          {
            view: dump_gfxinfo_array[0].to_i,
            display_lists_kb: dump_gfxinfo_array[2].to_f.round(2),
            frames_rendered: dump_gfxinfo_array[7].to_i,
            total_memory: (dump_gfxinfo_array[10].to_f / 1024).round(2),
            time: dump_gfxinfo_array.last,
          }
        end
      end

      def export_as_google_api_format_gfx(from_gfxinfo_usage)
        google_api_data_format = empty_google_api_format_gfx

        from_gfxinfo_usage.each do |hash|
          a_google_api_data_format = {
            c: [
              { v: hash[:time] },
              { v: hash[:view] },
              { v: hash[:display_lists_kb] },
            ]
          }
          google_api_data_format[:rows].push(a_google_api_data_format)
        end

        JSON.generate google_api_data_format
      end

      def export_as_google_api_format_mem(from_gfxinfo_usage)
        google_api_data_format = empty_google_api_format_mem

        from_gfxinfo_usage.each do |hash|
          a_google_api_data_format = {
            c: [
              { v: hash[:time] },
              { v: hash[:total_memory] },
            ]
          }
          google_api_data_format[:rows].push(a_google_api_data_format)
        end

        JSON.generate google_api_data_format
      end

      def export_as_google_api_format_frame(from_gfxinfo_usage)
        google_api_data_format = empty_google_api_format_frame

        from_gfxinfo_usage.each do |hash|
          a_google_api_data_format = {
            c: [
              { v: hash[:time] },
              { v: hash[:frames_rendered] },
            ]
          }
          google_api_data_format[:rows].push(a_google_api_data_format)
        end

        JSON.generate google_api_data_format
      end

      def create_graph(data_file_path, graph_opts = {}, output_file_path)
        self.save(Droid::Monitor::GoogleApiTemplate.create_graph(data_file_path, graph_opts),
                  output_file_path)
      end

      private

      def empty_google_api_format_gfx
        {
          cols: [
            { label: 'time', type: 'string' },
            { label: 'view', type: 'number' },
            { label: 'display_lists_kb', type: 'number' },
          ],
          rows: [
          ],
        }
      end

      def empty_google_api_format_mem
        {
          cols: [
            { label: 'time', type: 'string' },
            { label: 'total_memory', type: 'number' },
          ],
          rows: [
          ],
        }
      end

      def empty_google_api_format_frame
        {
          cols: [
            { label: 'time', type: 'string' },
            { label: 'frames_rendered', type: 'number' },
          ],
          rows: [
          ],
        }
      end


    end # class Gfxinfo
  end # module Monitor
end # module Droid
