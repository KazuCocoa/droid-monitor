require_relative "monitor/version"

module Droid
  module Monitor
    class Adb
      attr_accessor :package, :device_serial, :api_level

      def initialize( opts = {})
        fail 'opts must be a hash' unless opts.is_a? Hash
        fail 'Package name is required.' unless opts[:package]
        @package = opts[:package]
        @device_serial = opts[:device_serial] || ""
        @api_level = device_sdk_version
      end

      # @return [Integer] message from adb command
      # e.g: 17
      def device_sdk_version
        `#{adb_shell} getprop ro.build.version.sdk`.chomp.to_i
      end

      # @return [String] message from adb command
      def dump_cpuinfo
        `#{adb_shell} dumpsys cpuinfo`.chomp
      end

      # @return [String] message from adb command
      def dump_meminfo
        `#{adb_shell} dumpsys meminfo #{@package}`.chomp
      end

      private

      def adb
        fail "ANDROID_HOME is not set" unless ENV["ANDROID_HOME"]
        "#{ENV["ANDROID_HOME"]}/platform-tools/adb"
      end

      def device_serial_option
        return "" unless @device_serial && @device_serial != ""
        "-s #{@device_serial}"
      end

      def adb_shell
        "#{adb} #{device_serial_option} shell"
      end
    end # class Adb
  end # module Monitor
end # module Droid
