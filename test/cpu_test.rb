require 'test/unit'

require './lib/droid/monitor/cpu'

class CpuTest < Test::Unit::TestCase

  def setup
    # Do nothing
  end

  def teardown
    # Do nothing
  end

  def test_initialize
    cpu = Droid::Monitor::Cpu.new("com.sample.package", "")
    assert_instance_of(Droid::Monitor::Cpu, cpu)

    cpu.api_level = 18
    assert_equal("com.sample.package", cpu.package)
    assert_equal("", cpu.device_serial)
    assert_equal(18, cpu.api_level)
    assert_equal([], cpu.cpu_usage)
  end
end