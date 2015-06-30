require 'test/unit'

require './lib/droid/monitor/net'

PACKAGE_PID = <<-EOS
userId=10475 gids=[1028, 1015, 3003]
EOS

TCP_RCV = "174934"

TCP_SND = "374934"

class MemoryTest < Test::Unit::TestCase

  def setup
    @net = Droid::Monitor::Net.new( { package: "com.android.chrome" } )
  end

  def teardown
    @net.clear_tcps
    @net = nil
  end

  def test_initialize
    assert_instance_of(Droid::Monitor::Net, @net)

    assert_equal("com.android.chrome", @net.package)
    assert_equal([], @net.tcp_rec)
    assert_equal([], @net.tcp_snd)
  end

  def test_push_current_time
    assert_equal(@net.merge_current_time({}).length, 1)
  end

  def test_dump_net_recive_once
    expected = [174934]
    assert_equal(expected, @net.dump_tcp_rcv_usage(TCP_RCV))
  end

  def test_dump_net_recive_zero
    dummy_array = [0]

    @net.store_tcp_rec(dummy_array)

    expected_json = "[{\"tcp_rec\":0,\"time\":\"#{@net.tcp_rec[0][:time]}\"}]"
    assert_equal(expected_json, JSON.generate(@net.tcp_rec))
  end

  def test_dump_net_recive_twice
    dummy_array = [0]

    @net.store_tcp_rec(dummy_array)

    result = @net.dump_tcp_rcv_usage(TCP_RCV)

    @net.store_tcp_rec(result)

    expected_json = "[{\"tcp_rec\":0,\"time\":\"#{@net.tcp_rec[0][:time]}\"},{\"tcp_rec\":174934,\"time\":\"#{@net.tcp_rec[1][:time]}\"}]"
    assert_equal(expected_json, JSON.generate(@net.tcp_rec))
  end

  def test_dump_net_send_once
    expected = [374934]
    assert_equal(expected, @net.dump_tcp_snd_usage(TCP_SND))
  end

  def test_dump_net_send_zero
    dummy_array = [0]

    @net.store_tcp_snd(dummy_array)

    expected_json = "[{\"tcp_snd\":0,\"time\":\"#{@net.tcp_snd[0][:time]}\"}]"
    assert_equal(expected_json, JSON.generate(@net.tcp_snd))
  end

  def test_dump_net_send_twice
    dummy_array = [0]

    @net.store_tcp_snd(dummy_array)

    result = @net.dump_tcp_snd_usage(TCP_SND)

    @net.store_tcp_snd(result)

    expected_json = "[{\"tcp_snd\":0,\"time\":\"#{@net.tcp_snd[0][:time]}\"},{\"tcp_snd\":374934,\"time\":\"#{@net.tcp_snd[1][:time]}\"}]"
    assert_equal(expected_json, JSON.generate(@net.tcp_snd))
  end


=begin
  def test_memory_usage
    @memory.api_level = 18

    expected = {
      realtime: 376894346,
      uptime: 69627589,
    }

    result = @memory.transfer_total_memory_to_hash(@memory.dump_memory_usage(SAMPLE_DATA_43))
    assert_equal(result, expected)
  end


  def test_memory_details_api_level18
    @memory.api_level = 18

    expected = {
      pss_total: 28929,
      shared_dirty: 7308,
      private_dirty: 25960,
      heap_size: 24684,
      heap_alloc: 15381,
      heap_free: 6342,
    }

    result = @memory.transfer_total_memory_details_to_hash(@memory.dump_memory_details_usage(SAMPLE_DATA_43))
    assert_equal(result, expected)
  end

  def test_memory_details_api_level19
    @memory.api_level = 19

    expected = {
      pss_total: 44563,
      private_dirty: 36396,
      private_clean: 5372,
      swapped_dirty: 0,
      heap_size: 40720,
      heap_alloc: 38518,
      heap_free: 2045,
    }
    result = @memory.transfer_total_memory_details_to_hash(@memory.dump_memory_details_usage(SAMPLE_DATA_44))
    assert_equal(result, expected)
  end

  def test_transfer_from_hash_empty_to_json_memory_api_level18
    @memory.api_level = 18

    dummy_array = %w()

    @memory.store_memory_usage(dummy_array)

    expected_json = "[{\"uptime\":0,\"realtime\":0,\"time\":\"#{@memory.memory_usage[0][:time]}\"}]"
    assert_equal(expected_json, JSON.generate(@memory.memory_usage))
  end

  def test_transfer_from_hash_empty_to_json_memory_details_api_level18
    @memory.api_level = 18

    dummy_array = %w()

    @memory.store_memory_details_usage(dummy_array)

    expected_json = "[{\"pss_total\":0,\"shared_dirty\":0,\"private_dirty\":0," +
      "\"heap_size\":0,\"heap_alloc\":0,\"heap_free\":0,\"time\":\"#{@memory.memory_detail_usage[0][:time]}\"}]"
    assert_equal(expected_json, JSON.generate(@memory.memory_detail_usage))
  end

  def test_transfer_from_hash_empty_to_json_memory_details_api_level18_twice
    @memory.api_level = 18

    result = @memory.dump_memory_details_usage(SAMPLE_DATA_43)

    @memory.store_memory_details_usage(result)
    @memory.store_memory_details_usage(result)

    expected_json = "[{\"pss_total\":28929,\"shared_dirty\":7308,\"private_dirty\":25960," +
      "\"heap_size\":24684,\"heap_alloc\":15381,\"heap_free\":6342," +
      "\"time\":\"#{@memory.memory_detail_usage[0][:time]}\"}," +
      "{\"pss_total\":28929,\"shared_dirty\":7308,\"private_dirty\":25960," +
      "\"heap_size\":24684,\"heap_alloc\":15381,\"heap_free\":6342," +
      "\"time\":\"#{@memory.memory_detail_usage[1][:time]}\"}]"

    assert_equal(expected_json, JSON.generate(@memory.memory_detail_usage))

    expected_google = "{\"cols\":[{\"label\":\"time\",\"type\":\"string\"},{\"label\":\"pss_total\"," +
      "\"type\":\"number\"},{\"label\":\"shared_dirty\",\"type\":\"number\"},{\"label\":\"private_dirty\"," +
      "\"type\":\"number\"},{\"label\":\"heap_size\",\"type\":\"number\"},{\"label\":\"heap_alloc\"," +
      "\"type\":\"number\"},{\"label\":\"heap_free\",\"type\":\"number\"}]," +
      "\"rows\":[{\"c\":[{\"v\":\"#{@memory.memory_detail_usage[0][:time]}\"},{\"v\":28929}," +
      "{\"v\":7308},{\"v\":25960},{\"v\":24684},{\"v\":15381},{\"v\":6342}]}," +
      "{\"c\":[{\"v\":\"#{@memory.memory_detail_usage[1][:time]}\"},{\"v\":28929},{\"v\":7308},{\"v\":25960}," +
      "{\"v\":24684},{\"v\":15381},{\"v\":6342}]}]}"
    assert_equal(expected_google, @memory.export_as_google_api_format(@memory.memory_detail_usage))
  end


  def test_transfer_from_hash_empty_to_json_memory_details_api_level19
    @memory.api_level = 19

    dummy_array = %w(13:43:32.556)

    @memory.store_memory_details_usage(dummy_array)
    expected_json = "[{\"pss_total\":0,\"private_dirty\":0,\"private_clean\":0," +
      "\"swapped_dirty\":0,\"heap_size\":0,\"heap_alloc\":0,\"heap_free\":0," +
      "\"time\":\"#{@memory.memory_detail_usage[0][:time]}\"}]"
    assert_equal(expected_json, JSON.generate(@memory.memory_detail_usage))
  end

  def test_transfer_from_hash_empty_to_json_memory_details_api_level19_twice
    @memory.api_level = 19

    result = @memory.dump_memory_details_usage(SAMPLE_DATA_44)

    @memory.store_memory_details_usage(result)
    @memory.store_memory_details_usage(result)

    expected_json = "[{\"pss_total\":44563,\"private_dirty\":36396,\"private_clean\":5372,\"swapped_dirty\":0," +
      "\"heap_size\":40720,\"heap_alloc\":38518,\"heap_free\":2045," +
      "\"time\":\"#{@memory.memory_detail_usage[0][:time]}\"}," +
      "{\"pss_total\":44563,\"private_dirty\":36396," +
      "\"private_clean\":5372,\"swapped_dirty\":0," +
      "\"heap_size\":40720,\"heap_alloc\":38518,\"heap_free\":2045," +
      "\"time\":\"#{@memory.memory_detail_usage[1][:time]}\"}]"

    assert_equal(expected_json, JSON.generate(@memory.memory_detail_usage))

    expected_google = "{\"cols\":[{\"label\":\"time\",\"type\":\"string\"},{\"label\":\"pss_total\"," +
      "\"type\":\"number\"},{\"label\":\"private_dirty\",\"type\":\"number\"},{\"label\":\"private_clean\"," +
      "\"type\":\"number\"},{\"label\":\"swapped_dirty\",\"type\":\"number\"},{\"label\":\"heap_size\"," +
      "\"type\":\"number\"},{\"label\":\"heap_alloc\",\"type\":\"number\"},{\"label\":\"heap_free\"," +
      "\"type\":\"number\"}],\"rows\":[{\"c\":[{\"v\":\"#{@memory.memory_detail_usage[0][:time]}\"}," +
      "{\"v\":44563},{\"v\":36396},{\"v\":5372},{\"v\":0},{\"v\":40720},{\"v\":38518},{\"v\":2045}]}," +
      "{\"c\":[{\"v\":\"#{@memory.memory_detail_usage[1][:time]}\"},{\"v\":44563},{\"v\":36396}," +
      "{\"v\":5372},{\"v\":0},{\"v\":40720},{\"v\":38518},{\"v\":2045}]}]}"

    assert_equal(expected_google, @memory.export_as_google_api_format(@memory.memory_detail_usage))
  end
=end
end
