# frozen_string_literal: true

require 'test/unit'

require './lib/droid/monitor/net'

PACKAGE_PID = <<~EOS
  userId=10475 gids=[1028, 1015, 3003]
EOS

TCP_REC = '174934'

TCP_SND = '374934'

class NetTest < Test::Unit::TestCase
  def setup
    @net = Droid::Monitor::Net.new(package: 'com.android.chrome')
  end

  def teardown
    @net.clear_tcps
    @net = nil
  end

  def test_initialize
    assert_instance_of(Droid::Monitor::Net, @net)

    assert_equal('com.android.chrome', @net.package)
    assert_equal([], @net.tcp_rec)
    assert_equal([], @net.tcp_snd)
  end

  def test_push_current_time
    assert_equal(@net.merge_current_time({}).length, 1)
  end

  def test_dump_net_recive_once
    expected = [174_934]
    assert_equal(expected, @net.dump_tcp_rec_usage(TCP_REC))
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

    result = @net.dump_tcp_rec_usage(TCP_REC)

    @net.store_tcp_rec(result)

    expected_json = "[{\"tcp_rec\":0,\"time\":\"#{@net.tcp_rec[0][:time]}\"},{\"tcp_rec\":174934,\"time\":\"#{@net.tcp_rec[1][:time]}\"}]"
    assert_equal(expected_json, JSON.generate(@net.tcp_rec))
  end

  def test_dump_net_send_once
    expected = [374_934]
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
end
