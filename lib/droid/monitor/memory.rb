require_relative "../monitor"
require_relative "common/commons"

require "json"

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

      # @param [Array] dumped_memory Array of dumped memory data
      # @return [Hash] Google API formatted data
      def push_to_memory_usage(dumped_memory)
        @memory_usage.push self.merge_current_time(transfer_total_memory_to_hash(dumped_memory))
      end

      # @param [Array] dumped_memory_details Array of dumped memory data
      # @return [Hash] Google API formatted data
      def push_to_memory_details_usage(dumped_memory_details)
        @memory_detail_usage.push self.merge_current_time(transfer_total_memory_to_hash(dumped_memory_details))
      end

      def save_memory_as_google_api_into(file_path)
        self.save(export_as_google_api_format(@memory_usage), file_path)
      end

      def save_memory_details_as_google_api_into(file_path)
        self.save(export_as_google_api_format(@memory_detail_usage), file_path)
      end

      def transfer_up_real_time_to_hash(data)
        uptime_realtime(data)
      end

      def transfer_total_memory_to_hash(data)
        if @api_level.to_i >= 19
          total_memory_details_api_level_over_44(data)
        else
          total_memory_details_api_level_under_43(data)
        end
      end

      def export_as_google_api_format(data)
        if @api_level.to_i >= 19
          google_api_data_format = empty_google_api_format_over44
          data.each do |hash|
            a_google_api_data_format = {
              c: [
                { v: hash[:time] },
                { v: hash[:pss_total] },
                { v: hash[:private_dirty] },
                { v: hash[:private_clean] },
                { v: hash[:swapped_dirty] },
                { v: hash[:heap_size] },
                { v: hash[:heap_alloc] },
                { v: hash[:heap_free] },
              ],
            }
            google_api_data_format[:rows].push(a_google_api_data_format)
          end
          JSON.generate google_api_data_format
        else
          google_api_data_format = empty_google_api_format_over43

          data.each do |hash|
            a_google_api_data_format = {
              c: [
                { v: hash[:time] },
                { v: hash[:pss_total] },
                { v: hash[:shared_dirty] },
                { v: hash[:private_dirty] },
                { v: hash[:heap_size] },
                { v: hash[:heap_alloc] },
                { v: hash[:heap_free] },
              ],
            }
            google_api_data_format[:rows].push(a_google_api_data_format)
          end

          JSON.generate google_api_data_format
        end
      end

      private

      def empty_google_api_format_over44
        {
          cols: [
            { label: 'time', type: 'string' },
            { label: 'pss_total', type: 'number' },
            { label: 'private_dirty', type: 'number' },
            { label: 'private_clean', type: 'number' },
            { label: 'swapped_dirty', type: 'number' },
            { label: 'heap_size', type: 'number' },
            { label: 'heap_alloc', type: 'number' },
            { label: 'heap_free', type: 'number' },
          ],
          rows: [
          ],
        }
      end

      def empty_google_api_format_over43
        {
          cols: [
            { label: 'time', type: 'string' },
            { label: 'pss_total', type: 'number' },
            { label: 'shared_dirty', type: 'number' },
            { label: 'private_dirty', type: 'number' },
            { label: 'heap_size', type: 'number' },
            { label: 'heap_alloc', type: 'number' },
            { label: 'heap_free', type: 'number' },
          ],
          rows: [
          ],
        }
      end

      def uptime_realtime(data)
        {
          uptime: data[1].to_i ||= 0,
          realtime: data[3].to_i ||= 0,
          time: data.last,
        }
      end

      def total_memory_details_api_level_over_44(data)
        {
          pss_total: data[1].to_i ||= 0,
          private_dirty: data[2].to_i ||= 0,
          private_clean: data[3].to_i ||= 0,
          swapped_dirty: data[4].to_i ||= 0,
          heap_size: data[5].to_i ||= 0,
          heap_alloc: data[6].to_i ||= 0,
          heap_free: data[7].to_i ||= 0,
        }
      end

      def total_memory_details_api_level_under_43(data)
        {
          pss_total: data[1].to_i ||= 0,
          shared_dirty: data[2].to_i ||= 0,
          private_dirty: data[3].to_i ||= 0,
          heap_size: data[4].to_i ||= 0,
          heap_alloc: data[5].to_i ||= 0,
          heap_free: data[6].to_i ||= 0,
        }
      end

    end # class Memory
  end # module Monitor
end # module Droid
