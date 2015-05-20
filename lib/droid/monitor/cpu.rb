require_relative "../monitor"
require_relative "common/commons"

module Droid
  module Monitor
    class Cpu < Droid::Monitor::Adb
      attr_reader :cpu_usage

      include Droid::Monitor::Utils

      def initialize(package, device_serial)
        super(package, device_serial)
        @cpu_usage = []
      end

      def dump_cpu_usage(dump_data)
        dump = dump_data.scan(/^.*#{self.package}.*$/).map(&:strip).first.split(/\s/).reject(&:empty?)
        fail 'no package' if /^Load:$/ =~ dump[0]
        dump
      rescue StandardError => e
        puts e
        []
      end

    end # class Cpu
  end # module Monitor
end # module Droid
