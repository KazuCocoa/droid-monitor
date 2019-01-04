# frozen_string_literal: true

require_relative 'monitor/version'
require_relative 'monitor/common/timer'
require_relative 'monitor/executor/executor'

require 'open3'

module Droid
  module Monitor
    class Adb
      attr_accessor :package, :device_serial, :api_level

      def initialize(opts = {})
        raise 'opts must be a hash' unless opts.is_a? Hash
        raise 'Package name is required.' unless opts[:package]

        @package = opts[:package]
        @device_serial = opts[:device_serial] || ''
        @api_level = device_sdk_version
        @debug = opts[:debug]
      end

      # @return [Integer] message from adb command
      # e.g: 17
      def device_sdk_version
        run_adb("#{adb_shell} getprop ro.build.version.sdk").to_i
      end

      # @return [String] message from adb command
      def dump_package_info
        run_adb("#{adb_shell} dumpsys package #{@package}")
      end

      # @return [String] message from adb command
      def dump_cpuinfo
        run_adb("#{adb_shell} dumpsys cpuinfo")
      end

      # @return [String] message from adb command
      # "17742  1  15% S    55 2279532K 128100K  fg u0_a124  your.cpackage\r\n"
      def dump_cpuinfo_with_top
        run_adb("#{adb_shell} top -d 0.5 -n 1 | grep #{@package}")
      end

      # @return [String] message from adb command
      def dump_meminfo
        run_adb("#{adb_shell} dumpsys meminfo #{@package}")
      end

      def dump_tcp_rec
        pid = get_pid
        return 0 if pid == -1

        puts "pid is #{pid}" if @debug
        run_adb("#{adb_shell} cat proc/uid_stat/#{pid}/tcp_rcv").to_i
      end

      def dump_tcp_snd
        pid = get_pid
        return 0 if pid == -1

        puts "pid is #{pid}" if @debug
        run_adb("#{adb_shell} cat proc/uid_stat/#{pid}/tcp_snd").to_i
      end

      def dump_gfxinfo
        run_adb("#{adb_shell} dumpsys gfxinfo #{@package}")
      end

      private

      def adb
        raise 'ANDROID_HOME is not set' unless ENV['ANDROID_HOME']

        "#{ENV['ANDROID_HOME']}/platform-tools/adb"
      end

      def device_serial_option
        return '' unless @device_serial && @device_serial != ''

        "-s \"#{@device_serial}\""
      end

      def adb_shell
        "#{adb} #{device_serial_option} shell"
      end

      # @return [String] line of packages regarding pid and so on
      def get_pid
        dump = run_adb("#{adb_shell} dumpsys package #{@package}")
        return -1 if dump.nil?

        userid = dump.scan(/userId=[0-9]+/)
        return -1 if userid.empty?

        userid.uniq.first.delete('userId=')
      end

      def run_adb(cmd)
        out_s, out_e, status = Open3.capture3(cmd)
        puts "error: device not found which serial is #{@device_serial}" if out_e.include?('error: device not found')
        out_s.chomp unless out_s.nil? || out_s.empty?
      end
    end # class Adb
  end # module Monitor
end # module Droid
