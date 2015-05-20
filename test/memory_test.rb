require 'test/unit'

require './lib/droid/monitor/memory'

class MemoryTest < Test::Unit::TestCase

  def setup
    # Do nothing
  end

  def teardown
    # Do nothing
  end

  def test_initialize
    memory = Droid::Monitor::Memory.new("com.sample.package", "")
    assert_instance_of(Droid::Monitor::Memory, memory)

    memory.api_level = 19
    assert_equal("com.sample.package", memory.package)
    assert_equal("", memory.device_serial)
    assert_equal(19, memory.api_level)
    assert_equal([], memory.memory_usage)
    assert_equal([], memory.memory_detail_usage)
  end
end