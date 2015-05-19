require_relative "../monitor"

module Droid
  module Monitor
    class Memory < Adb

      def initialize(package, device_serial)
        super(package, device_serial)
        @memory_usage = []
        @memory_detail_usage = []
      end

    end # class Memory
  end # module Monitor
end # module Droid
