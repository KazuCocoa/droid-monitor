require_relative "../monitor"
require_relative "common/commons"
require_relative "report/google_api_template"

require "json"

module Droid
  module Monitor
    class Cpu < Droid::Monitor::Adb
      attr_reader :cpu_usage

      include Droid::Monitor::Utils

      def initialize(opts = {})
        super(opts)
        @cpu_usage = []
      end

      def clear_cpu_usage
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

      # called directory
      def store_dumped_cpu_usage
        self.store_cpu_usage(self.dump_cpu_usage(self.dump_cpuinfo))
      end

      def save_cpu_usage_as_google_api(file_path)
        self.save(export_as_google_api_format(@cpu_usage), file_path)
      end

      def store_cpu_usage(dumped_cpu)
        @cpu_usage.push self.merge_current_time(transfer_total_cpu_to_hash(dumped_cpu))
      end

      def transfer_total_cpu_to_hash(dump_cpu_array)
        if dump_cpu_array.length == 1
          {
            total_cpu: '0%',
            process: 'no package process',
            user: '0%',
            kernel: '0%',
            time: dump_cpu_array.last,
          }
        else
          {
            total_cpu: dump_cpu_array[0],
            process: dump_cpu_array[1],
            user: dump_cpu_array[2],
            kernel: dump_cpu_array[5],
            time: dump_cpu_array.last,
          }
        end
      end

      def export_as_google_api_format(from_cpu_usage)
        google_api_data_format = empty_google_api_format

        from_cpu_usage.each do |hash|
          a_google_api_data_format = {
            c: [
              { v: hash[:time] },
              { v: hash[:total_cpu].delete('%').to_f },
              { v: hash[:user].delete('%').to_f },
              { v: hash[:kernel].delete('%').to_f },
            ]
          }
          google_api_data_format[:rows].push(a_google_api_data_format)
        end

        JSON.generate google_api_data_format
      end

      def create_graph(title, header1, input_file_path, graph_setting, output_file_path)
        self.save(Droid::Monitor::GoogleApiTemplate.create_graph(title, header1, input_file_path, graph_setting),
                  output_file_path)
      end

      private

      def empty_google_api_format
        {
          cols: [
            { label: 'time', type: 'string' },
            { label: 'total_cpu', type: 'number' },
            { label: 'user', type: 'number' },
            { label: 'kernel', type: 'number' },
          ],
          rows: [
          ],
        }
      end

    end # class Cpu
  end # module Monitor
end # module Droid
