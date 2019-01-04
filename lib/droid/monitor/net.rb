# frozen_string_literal: true

require_relative '../monitor'
require_relative 'common/commons'
require_relative 'report/google_api_template'

require 'json'

module Droid
  module Monitor
    class Net < Droid::Monitor::Adb
      attr_reader :tcp_rec, :tcp_snd

      include Droid::Monitor::Utils

      def initialize(opts = {})
        super(opts)
        @tcp_rec = []
        @tcp_snd = []
      end

      def clear_tcps_rec
        @tcp_rec = []
      end

      def clear_tcps_snd
        @tcp_snd = []
      end

      def clear_tcps
        clear_tcps_rec
        clear_tcps_snd
      end

      def dump_tcp_rec_usage(dump_data)
        [dump_data.to_i]
      end

      def dump_tcp_snd_usage(dump_data)
        [dump_data.to_i]
      end

      # called directory
      def store_dumped_tcp_rec
        store_tcp_rec(dump_tcp_rec_usage(dump_tcp_rec))
      end

      def store_dumped_tcp_snd
        store_tcp_snd(dump_tcp_snd_usage(dump_tcp_snd))
      end

      def save_cpu_usage_as_google_api_rec(file_path)
        save(export_as_google_api_format_rec(@tcp_rec), file_path)
      end

      def save_cpu_usage_as_google_api_snd(file_path)
        save(export_as_google_api_format_snd(@tcp_snd), file_path)
      end

      def store_tcp_rec(dumped_tcp_rec)
        @tcp_rec.push merge_current_time(transfer_tcp_rec_to_hash_rec(dumped_tcp_rec))
      end

      def store_tcp_snd(dumped_tcp_snd)
        @tcp_snd.push merge_current_time(transfer_tcp_rec_to_hash_snd(dumped_tcp_snd))
      end

      def transfer_tcp_rec_to_hash_rec(dumped_tcp_rec)
        {
          tcp_rec: dumped_tcp_rec[0]
        }
      end

      def transfer_tcp_rec_to_hash_snd(dumped_tcp_snd)
        {
          tcp_snd: dumped_tcp_snd[0]
        }
      end

      def export_as_google_api_format_rec(from_tcp_rec)
        google_api_data_format = empty_google_api_format_rec

        from_tcp_rec.each do |hash|
          a_google_api_data_format = {
            c: [
              { v: hash[:time] },
              { v: hash[:tcp_rec] }
            ]
          }
          google_api_data_format[:rows].push(a_google_api_data_format)
        end

        JSON.generate google_api_data_format
      end

      def export_as_google_api_format_snd(from_tcp_snd)
        google_api_data_format = empty_google_api_format_snd

        from_tcp_snd.each do |hash|
          a_google_api_data_format = {
            c: [
              { v: hash[:time] },
              { v: hash[:tcp_snd] }
            ]
          }
          google_api_data_format[:rows].push(a_google_api_data_format)
        end

        JSON.generate google_api_data_format
      end

      # @params [String] data_file_path A path to data.
      # @params [Hash] graph_opts A hash regarding graph settings.
      # @params [String] output_file_path A path you would like to export data.
      def create_graph(data_file_path, graph_opts = {}, output_file_path) # rubocop:disable Style/OptionalArguments
        save(Droid::Monitor::GoogleApiTemplate.create_graph(data_file_path, graph_opts),
             output_file_path)
      end

      private

      def empty_google_api_format_rec
        {
          cols: [
            { label: 'time', type: 'string' },
            { label: 'tcp_rec', type: 'number' }
          ],
          rows: []
        }
      end

      def empty_google_api_format_snd
        {
          cols: [
            { label: 'time', type: 'string' },
            { label: 'tcp_snd', type: 'number' }
          ],
          rows: []
        }
      end
    end # class Cpu
  end # module Monitor
end # module Droid
