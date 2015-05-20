module Droid
  module Monitor
    module Utils

      def push_current_time(array)
        array.push(Time.now.strftime('%T.%L'))
      end

    end
  end
end
