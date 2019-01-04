# frozen_string_literal: true

module Droid
  module Monitor
    class Executor
      class Base
        def execute(_timer)
          raise NotImplementedError
        end

        def save
          raise NotImplementedError
        end

        def kill
          raise NotImplementedError
        end
      end
    end
  end
end
