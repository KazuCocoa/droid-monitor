require 'test/unit'

require './lib/droid/monitor'

class MyTest < Test::Unit::TestCase

  # Called before every test method runs. Can be used
  # to set up fixture information.
  def setup
    # Do nothing
  end

  # Called after every test method runs. Can be used to tear
  # down fixture information.

  def teardown
    # Do nothing
  end

  # Fake test
  def test_initialize
    adb = Droid::Monitor::Adb.new("com.sample.package", "")
    assert_instance_of(Droid::Monitor::Adb, adb)

    adb.api_level = 19
    assert_equal("com.sample.package", adb.package)
    assert_equal("", adb.device_serial)
    assert_equal(19, adb.api_level)

  end
end