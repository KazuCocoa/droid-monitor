module Droid
  module Monitor
    module Timer
      class Executor
        attr_reader :interval

        # @param [int] interval Interval to wait
        def initialize(interval)
          @interval = interval
        end

        # @param [Block] &block Yield the block after sleep @interval
        # @return [Symbol] :finished
        def execute
          sleep interval
          yield

          :finished
        end

        # Loop `execute` until stopping its process
        # @param [Block] &block Yield the block after sleep @interval
        # @return [Symbol] :finished
        def execute_loop(&block)
          loop { execute(&block) }
        end

        # Start
        #     t = timer.execute_loop_thread { puts "#{Time.now}" }
        # Stop
        #     timer.kill_thread t
        #
        # Loop `execute` until stopping its process on the other thread
        # @param [Block] &block Yield the block after sleep @interval
        # @return [Symbol] :finished
        def execute_loop_thread(&block)
          Thread.new { loop { execute(&block) } }
        end

        # @param [Thread] thread Kill the thread
        def kill_thread(thread)
          Thread.kill thread
        end

        # @return [Array[Thread]] Return a list running thread on the process
        def thread_list
          Thread.list
        end
      end
    end
  end
end
