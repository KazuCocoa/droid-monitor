require_relative "../monitor"
require_relative "common/commons"

module Droid
  module Monitor
    class Memory < Droid::Monitor::Adb
      attr_reader :memory_usage, :memory_detail_usage

      include Droid::Monitor::Utils

      def initialize(package, device_serial)
        super(package, device_serial)
        @memory_usage = []
        @memory_detail_usage = []
      end

      def clear_memory_usage
        @memory_usage = []
      end

      def clear_memory_detail_usage
        @memory_detail_usage = []
      end

      def dump_memory_usage(dump_data)
        fail "no process" if dump_data == "No process found for: #{@package}"
        dump_data.scan(/^.*Uptime.*Realtime.*$/).map(&:strip).first.split(/\s/).reject(&:empty?)
      rescue StandardError => e
        puts e
        []
      end

      def dump_memory_details_usage(dump_data)
        fail "no process" if dump_data == "No process found for: #{@package}"
        dump_data.scan(/^.*TOTAL.*$/).map(&:strip).first.split(/\s/).reject(&:empty?)
      rescue StandardError => e
        puts e
        []
      end

    end # class Memory
  end # module Monitor
end # module Droid
