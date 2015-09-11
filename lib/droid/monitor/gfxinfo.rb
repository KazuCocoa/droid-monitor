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
        dump1 = dump_data.scan(/^.*views,.*kB\ of\ display\ lists,.*frames\ rendered/).first.split(/\s/).reject(&:empty?)
        dump2 = dump_data.scan(/^.*bytes,.*MB$/).first.split(/\s/).reject(&:empty?)
        dump1 + dump2
      rescue StandardError => e
        puts e
        []
      end

      # called directory
      def store_dumped_gfxinfo_usage
      end

      def save_gfxinfo_usage_as_google_api(file_path)
      end

      def store_gfxinfo_usage(dumped_gfxinfo)
      end

      def transfer_total_gfxinfo_to_hash(dump_gfxinfo_array)
      end

      def export_as_google_api_format(from_gfxinfo_usage)
      end

      def create_graph(data_file_path, graph_opts = {}, output_file_path)
      end

      private

      def empty_google_api_format
      end

    end # class Gfxinfo
  end # module Monitor
end # module Droid
