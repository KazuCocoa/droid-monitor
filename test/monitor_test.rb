require 'test/unit'

require './lib/droid/monitor'

class MonitorTest < Test::Unit::TestCase

  def setup
    # Do nothing
  end

  def teardown
    # Do nothing
  end

  def test_initialize
    adb = Droid::Monitor::Adb.new("com.sample.package", "")
    assert_instance_of(Droid::Monitor::Adb, adb)

    adb.api_level = 19
    assert_equal("com.sample.package", adb.package)
    assert_equal("", adb.device_serial)
    assert_equal(19, adb.api_level)

  end
end