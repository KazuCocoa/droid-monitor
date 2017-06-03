require 'test/unit'

require './lib/droid/monitor/common/timer'

module Droid
  module Monitor
    class TimerTest < Test::Unit::TestCase
      def test_timer
        timer = Timer::Executor.new(0.1)
        assert_equal(0.1, timer.interval)

        thread_size = Thread.list.size
        thread = timer.execute_loop_thread { 1 }
        assert_equal(thread_size + 1, Thread.list.size)
        assert_equal('run', thread.status)

        timer.kill_thread thread
        sleep 0.1
        assert_equal(false, thread.status)
        assert_equal(thread_size, Thread.list.size)
      end
    end
  end
end
