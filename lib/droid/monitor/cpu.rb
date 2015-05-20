require_relative "../monitor"

module Droid
  module Monitor
    class Cpu < Droid::Monitor::Adb
      attr_reader :cpu_usage

      def initialize(package, device_serial)
        super(package, device_serial)
        @cpu_usage = []
      end

    end # class Cpu
  end # module Monitor
end # module Droid
