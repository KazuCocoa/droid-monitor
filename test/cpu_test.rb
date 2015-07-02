require 'test/unit'

require './lib/droid/monitor/cpu'

SAMPLE_CPU_DATA_44 = <<-EOS
Load: 20.88 / 17.57 / 10.31
CPU usage from 7077ms to 1571ms ago:
  47% 844/system_server: 37% user + 10% kernel / faults: 2947 minor
  23% 3031/com.facebook.orca: 22% user + 0.3% kernel / faults: 553 minor
  18% 24281/android.process.media: 12% user + 5.2% kernel / faults: 910 minor
  9.2% 15887/com.linkbubble.playstore: 7.4% user + 1.8% kernel / faults: 137 minor
  7.4% 1038/com.android.systemui: 4.1% user + 3.2% kernel / faults: 23 minor
  6.1% 125/mmcqd/0: 0% user + 6.1% kernel
  6.1% 161/surfaceflinger: 2% user + 4.1% kernel
  6% 24263/com.android.chrome: 4.7% user + 1.2% kernel / faults: 1361 minor 17 major
  5.2% 20938/com.facebook.katana: 2.1% user + 3% kernel / faults: 64 minor
  2.7% 194/sdcard: 0.1% user + 2.5% kernel
  1.2% 60/kswapd0: 0% user + 1.2% kernel
  1.2% 11502/kworker/u:13: 0% user + 1.2% kernel
  1% 289/sensors.qcom: 0.1% user + 0.9% kernel
  0.9% 21403/com.mailboxapp: 0.7% user + 0.1% kernel / faults: 303 minor
  0.7% 144/jbd2/mmcblk0p19: 0% user + 0.7% kernel
  0.7% 1162/com.google.android.gms.persistent: 0.3% user + 0.3% kernel / faults: 37 minor
  0.3% 1762/mpdecision: 0% user + 0.3% kernel
  0.1% 18301/kworker/0:2: 0% user + 0.1% kernel
  0.3% 25698/com.google.android.gms.wearable: 0.3% user + 0% kernel / faults: 354 minor
  0% 158/netd: 0% user + 0% kernel / faults: 38 minor
  0.1% 191/logcat: 0.1% user + 0% kernel
  0% 1024/MC_Thread: 0% user + 0% kernel
  0.1% 1239/com.tul.aviate: 0.1% user + 0% kernel / faults: 4 minor
  0.1% 6799/kworker/0:0: 0% user + 0.1% kernel
  0% 14728/com.google.android.googlequicksearchbox:search: 0% user + 0% kernel / faults: 13 minor
  0% 24205/kworker/1:1: 0% user + 0% kernel
96% TOTAL: 49% user + 20% kernel + 26% iowait + 0.5% softirq
EOS

class CpuTest < Test::Unit::TestCase

  def setup
    @cpu = Droid::Monitor::Cpu.new( { package: "com.android.chrome" } )
  end

  def teardown
    @cpu = nil
  end

  def test_initialize
    assert_instance_of(Droid::Monitor::Cpu, @cpu)

    @cpu.api_level = 18
    assert_equal("com.android.chrome", @cpu.package)
    assert_equal("", @cpu.device_serial)
    assert_equal(18, @cpu.api_level)
    assert_equal([], @cpu.cpu_usage)
  end

  def test_push_current_time
    assert_equal(@cpu.merge_current_time({}).length, 1)
  end

  def test_dump_cpu_usage
    expected = %w(6% 24263/com.android.chrome: 4.7% user + 1.2% kernel / faults: 1361 minor 17 major)
    assert_equal(expected, @cpu.dump_cpu_usage(SAMPLE_CPU_DATA_44))
  end

  def test_transfer_from_hash_empty_to_json
    dummy_array = %w(13:43:32.556)

    @cpu.store_cpu_usage(dummy_array)
    expected_json = "[{\"total_cpu\":\"0%\",\"process\":\"no package process\",\"user\":\"0%\"," +
      "\"kernel\":\"0%\",\"time\":\"#{@cpu.cpu_usage[0][:time]}\"}]"

    assert_equal(expected_json, JSON.generate(@cpu.cpu_usage))
  end

  def test_transfer_from_hash_correct_to_json
    dummy_array = %w(4.7% 2273/com.sample.package:sample: 3.3% user + 1.3% kernel 13:43:32.556)

    @cpu.store_cpu_usage(dummy_array)
    expected_json = "[{\"total_cpu\":\"4.7%\",\"process\":\"2273/com.sample.package:sample:\"," +
      "\"user\":\"3.3%\",\"kernel\":\"1.3%\",\"time\":\"#{@cpu.cpu_usage[0][:time]}\"}]"
    assert_equal(expected_json, JSON.generate(@cpu.cpu_usage))
  end

  def test_convert_to_google_data_api_format_one
    dummy_array = %w(4.7% 2273/com.sample.package:sample: 3.3% user + 1.3% kernel 13:43:32.556)

    @cpu.store_cpu_usage(dummy_array)
    expected_json = "{\"cols\":[{\"label\":\"time\",\"type\":\"string\"}," +
      "{\"label\":\"total_cpu\",\"type\":\"number\"},{\"label\":\"user\",\"type\":\"number\"}," +
      "{\"label\":\"kernel\",\"type\":\"number\"}],\"rows\":[{\"c\":[{\"v\":\"#{@cpu.cpu_usage[0][:time]}\"}," +
      "{\"v\":4.7},{\"v\":3.3},{\"v\":1.3}]}]}"
    assert_equal(@cpu.export_as_google_api_format(@cpu.cpu_usage), expected_json)
  end

  def test_convert_to_google_data_api_format_many
    dummy_array = %w(4.7% 2273/com.sample.package:sample: 3.3% user + 1.3% kernel 13:43:32.556)

    @cpu.store_cpu_usage(dummy_array)
    @cpu.store_cpu_usage(dummy_array)
    expected_json = "{\"cols\":[{\"label\":\"time\",\"type\":\"string\"}," +
      "{\"label\":\"total_cpu\",\"type\":\"number\"},{\"label\":\"user\",\"type\":\"number\"}," +
      "{\"label\":\"kernel\",\"type\":\"number\"}],\"rows\":[{\"c\":[{\"v\":\"#{@cpu.cpu_usage[0][:time]}\"}," +
      "{\"v\":4.7},{\"v\":3.3},{\"v\":1.3}]},{\"c\":[{\"v\":\"#{@cpu.cpu_usage[1][:time]}\"}," +
      "{\"v\":4.7},{\"v\":3.3},{\"v\":1.3}]}]}"
    assert_equal(@cpu.export_as_google_api_format(@cpu.cpu_usage), expected_json)
  end

end
