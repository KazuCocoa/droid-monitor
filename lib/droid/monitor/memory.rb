require_relative "../monitor"

module Droid
  module Monitor
    class Memory < Droid::Monitor::Adb
      attr_reader :memory_usage, :memory_detail_usage

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

    end # class Memory
  end # module Monitor
end # module Droid
