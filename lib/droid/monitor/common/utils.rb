module Droid
  module Monitor
    module Utils
      def merge_current_time(hash)
        hash.merge(time: Time.now.strftime('%T.%L'))
      end

      def save(data, into_file_path)
        File.open(into_file_path, 'w') do |file|
          file.puts data
        end
      end
    end
  end
end
