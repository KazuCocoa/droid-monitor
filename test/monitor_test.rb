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
    adb = Droid::Monitor::Adb.new( { package: "com.sample.package" } )
    assert_instance_of(Droid::Monitor::Adb, adb)

    adb.api_level = 19
    assert_equal("com.sample.package", adb.package)
    assert_equal("", adb.device_serial)
    assert_equal(19, adb.api_level)
  end

  def test_intialize_with_device_serial
    adb = Droid::Monitor::Adb.new({ package: "com.sample.package", device_serial: "sample serial"})

    adb.api_level = 18
    assert_equal("com.sample.package", adb.package)
    assert_equal("sample serial", adb.device_serial)
    assert_equal(18, adb.api_level)
  end

end