# frozen_string_literal: true

require 'test/unit'

require './lib/droid/monitor/gfxinfo'

SAMPLE_GFXINFO = <<~EOS
  Applications Graphics Acceleration Info:
  Uptime: 14972669 Realtime: 14972664

  ** Graphics info for pid 29541 [com.android.chrome] **

  Recent DisplayList operations
          DrawDisplayList
            DrawDisplayList
              DrawDisplayList
                DrawColor
              DrawDisplayList
                DrawDisplayList
    RestoreToCount
  DrawColor
  DrawDisplayList
    Save
    ClipRect
    DrawDisplayList
      DrawDisplayList
        DrawDisplayList
          DrawDisplayList
            DrawDisplayList
              DrawDisplayList
                DrawColor
              DrawDisplayList
                DrawDisplayList
    RestoreToCount
  DrawColor
  DrawDisplayList
    Save
    ClipRect
    DrawDisplayList
      DrawDisplayList
        DrawDisplayList
          DrawDisplayList
            DrawDisplayList
              DrawDisplayList
                DrawColor
              DrawDisplayList
                DrawDisplayList
    RestoreToCount
  DrawColor
  DrawDisplayList
    Save
    ClipRect
    DrawDisplayList
      DrawDisplayList
        DrawDisplayList
          DrawDisplayList
            DrawDisplayList
              DrawDisplayList
                DrawColor
              DrawDisplayList
                DrawDisplayList
    RestoreToCount
  DrawColor

  Caches:
  Current memory usage / total memory usage (bytes):
    TextureCache            46528 / 25165824
    LayerCache                  0 / 16777216
    RenderBufferCache           0 /  2097152
    GradientCache           57344 /   524288
    PathCache                   0 / 10485760
    TextDropShadowCache         0 /  2097152
    PatchCache              26304 /   131072
    FontRenderer 0 A8      524288 /   524288
    FontRenderer 0 RGBA         0 /        0
    FontRenderer 0 total   524288 /   524288
  Other:
    FboCache                    1 /       16
  Total memory usage:
    654464 bytes, 0.62 MB

  Profile data in ms:

  	com.android.chrome/org.chromium.chrome.browser.ChromeTabbedActivity/android.view.ViewRootImpl@41fc59c8
  View hierarchy:

    com.android.chrome/org.chromium.chrome.browser.ChromeTabbedActivity/android.view.ViewRootImpl@41fc59c8
    41 views, 1.36 kB of display lists, 191 frames rendered


  Total ViewRootImpl: 1
  Total Views:        41
  Total DisplayList:  1.36 kB
EOS

SAMPLE_GFXINFO_5 = <<~EOS
  Applications Graphics Acceleration Info:
  Uptime: 6019250 Realtime: 13901895

  ** Graphics info for pid 26834 [com.android.chrome] **

  Recent DisplayList operations
                          ConcatMatrix
                          Save
                          DrawBitmap
                          RestoreToCount
                      DrawRenderNode
                        DrawRenderNode
                          Save
                          ClipRect
                          Translate
                          DrawRenderNode
                            DrawText
                            DrawText
                          RestoreToCount
                      DrawRenderNode
                        Save
                        ConcatMatrix
                        Save
                        DrawBitmap
                        RestoreToCount
                      DrawRenderNode
                        Save
                        ConcatMatrix
                        Save
                        DrawBitmap
                        RestoreToCount
                      RestoreToCount
                    DrawRenderNode
                      DrawRenderNode
                        DrawRenderNode
                        Save
                        ConcatMatrix
                        Save
                        DrawBitmap
                        RestoreToCount
                    RestoreToCount
                DrawRenderNode
      RestoreToCount
  RestoreToCount
  DrawRect
  DrawBitmap
  DrawBitmap
  DrawBitmap
  DrawBitmap
  DrawPatch
  DrawBitmap
  DrawBitmap
  DrawBitmap
  DrawBitmap
  DrawText
  DrawText

  Caches:
  Current memory usage / total memory usage (bytes):
    TextureCache           669300 / 50331648
    LayerCache                  0 / 33554432 (numLayers = 0)
    Layers total          0 (numLayers = 0)
    RenderBufferCache           0 /  4194304
    GradientCache               0 /  1048576
    PathCache                   0 / 25165824
    TessellationCache           0 /  1048576
    TextDropShadowCache         0 /  5242880
    PatchCache                960 /   131072
    FontRenderer 0 A8      524288 /   524288
    FontRenderer 0 RGBA         0 /        0
    FontRenderer 0 total   524288 /   524288
  Other:
    FboCache                    0 /        0
  Total memory usage:
    1194548 bytes, 1.14 MB

  Profile data in ms:

          com.android.chrome/org.chromium.chrome.browser.ChromeTabbedActivity/android.view.ViewRootImpl@27de7df5 (visibility=0)
  View hierarchy:

    com.android.chrome/org.chromium.chrome.browser.ChromeTabbedActivity/android.view.ViewRootImpl@27de7df5
    55 views, 51,03 kB of display lists


  Total ViewRootImpl: 1
  Total Views:        55
  Total DisplayList:  51,03 kB
EOS

SAMPLE_GFXINFO_6 = <<~EOS
  Applications Graphics Acceleration Info:
  Uptime: 9658130 Realtime: 9658130

  ** Graphics info for pid 9702 [com.android.chrome] **

  Stats since: 9656484850794ns
  Total frames rendered: 3
  Janky frames: 2 (66.67%)
  90th percentile: 101ms
  95th percentile: 101ms
  99th percentile: 101ms
  Number Missed Vsync: 2
  Number High input latency: 0
  Number Slow UI thread: 2
  Number Slow bitmap uploads: 0
  Number Slow issue draw commands: 1

  Caches:
  Current memory usage / total memory usage (bytes):
    TextureCache           878276 / 75497472
    LayerCache                  0 / 50331648 (numLayers = 0)
    Layers total          0 (numLayers = 0)
    RenderBufferCache           0 /  8388608
    GradientCache               0 /  1048576
    PathCache                   0 / 33554432
    TessellationCache           0 /  1048576
    TextDropShadowCache         0 /  6291456
    PatchCache                  0 /   131072
    FontRenderer 0 A8     1048576 /  1048576
    FontRenderer 0 RGBA         0 /        0
    FontRenderer 0 total  1048576 /  1048576
  Other:
    FboCache                    0 /        0
  Total memory usage:
    1926852 bytes, 1.84 MB

  Profile data in ms:

          com.android.chrome/org.chromium.chrome.browser.firstrun.FirstRunActivityStaging/android.view.ViewRootImpl@6b40547 (visibility=0)
  Stats since: 9656484850794ns
  Total frames rendered: 3
  Janky frames: 2 (66.67%)
  90th percentile: 101ms
  95th percentile: 101ms
  99th percentile: 101ms
  Number Missed Vsync: 2
  Number High input latency: 0
  Number Slow UI thread: 2
  Number Slow bitmap uploads: 0
  Number Slow issue draw commands: 1

  View hierarchy:

    com.android.chrome/org.chromium.chrome.browser.firstrun.FirstRunActivityStaging/android.view.ViewRootImpl@6b40547
    21 views, 31.36 kB of display lists


  Total ViewRootImpl: 1
  Total Views:        21
  Total DisplayList:  31.36 kB
EOS

class GfxinfoTest < Test::Unit::TestCase
  def setup
    @gfx = Droid::Monitor::Gfxinfo.new(package: 'com.android.chrome')
  end

  def teardown
    @gfx = nil
  end

  def test_initialize
    assert_instance_of(Droid::Monitor::Gfxinfo, @gfx)

    @gfx.api_level = 18
    assert_equal('com.android.chrome', @gfx.package)
    assert_equal('', @gfx.device_serial)
    assert_equal(18, @gfx.api_level)
    assert_equal([], @gfx.gfxinfo_usage)
  end

  def test_dump_gfxinfo_usage
    expected = %w[654464 bytes 0.62 MB 41 views 1.36 kB of display lists 191 frames rendered]

    assert_equal(expected, @gfx.dump_gfxinfo_usage(SAMPLE_GFXINFO))
  end

  def test_dump_gfxinfo_usage_for_API21
    expected = %w[1194548 bytes 1.14 MB 55 views 51,03 kB of display lists]

    assert_equal(expected, @gfx.dump_gfxinfo_usage(SAMPLE_GFXINFO_5))
  end

  def test_dump_gfxinfo_usage_for_API23
    expected = %w(1926852 bytes 1.84 MB 21 views 31.36 kB of display lists Total frames rendered: 3 Janky frames: 2 (66.67%))
    @gfx.api_level = 23
    assert_equal(expected, @gfx.dump_gfxinfo_usage(SAMPLE_GFXINFO_6))
  end

  def test_push_current_time
    assert_equal(@gfx.merge_current_time({}).length, 1)
  end

  def test_transfer_from_hash_empty_to_json
    dummy_array = %w[13:43:32.556]

    @gfx.store_gfxinfo_usage(dummy_array)
    expected_json = '[{"view":0,"display_lists_kb":0,"frames_rendered":0,' \
                    "\"total_memory\":0,\"time\":\"#{@gfx.gfxinfo_usage[0][:time]}\"}]"
    assert_equal(expected_json, JSON.generate(@gfx.gfxinfo_usage))
  end

  def test_transfer_from_hash_correct_to_json
    dummy_array = %w[5781894 bytes 5.51 MB 465 views 38.00 kB of display lists 354 frames rendered 13:43:32.556]

    @gfx.store_gfxinfo_usage(dummy_array)
    expected_json = '[{"view":465,"display_lists_kb":38.0,"frames_rendered":354,' \
                    "\"total_memory\":5646.38,\"time\":\"#{@gfx.gfxinfo_usage[0][:time]}\"}]"
    assert_equal(expected_json, JSON.generate(@gfx.gfxinfo_usage))
  end

  def test_convert_to_google_data_api_format_gfx_one
    dummy_array = %w[5781894 bytes 5.51 MB 465 views 38.00 kB of display lists 354 frames rendered 13:43:32.556]

    @gfx.store_gfxinfo_usage(dummy_array)
    expected_json = '{"cols":[{"label":"time","type":"string"},{"label":"view","type":"number"},' \
                    "{\"label\":\"display_lists_kb\",\"type\":\"number\"}],\"rows\":[{\"c\":[{\"v\":\"#{@gfx.gfxinfo_usage[0][:time]}\"}," \
                    '{"v":465},{"v":38.0}]}]}'
    assert_equal(@gfx.export_as_google_api_format_gfx(@gfx.gfxinfo_usage), expected_json)
  end

  def test_convert_to_google_data_api_format_mem_one
    dummy_array = %w[5781894 bytes 5.51 MB 465 views 38.00 kB of display lists 354 frames rendered 13:43:32.556]

    @gfx.store_gfxinfo_usage(dummy_array)
    expected_json = '{"cols":[{"label":"time","type":"string"},' \
                    "{\"label\":\"total_memory\",\"type\":\"number\"}],\"rows\":[{\"c\":[{\"v\":\"#{@gfx.gfxinfo_usage[0][:time]}\"}," \
                    '{"v":5646.38}]}]}'
    assert_equal(@gfx.export_as_google_api_format_mem(@gfx.gfxinfo_usage), expected_json)
  end

  def test_convert_to_google_data_api_format_frame_one
    dummy_array = %w[5781894 bytes 5.51 MB 465 views 38.00 kB of display lists 354 frames rendered 13:43:32.556]

    @gfx.store_gfxinfo_usage(dummy_array)
    expected_json = '{"cols":[{"label":"time","type":"string"},' \
                    "{\"label\":\"frames_rendered\",\"type\":\"number\"}],\"rows\":[{\"c\":[{\"v\":\"#{@gfx.gfxinfo_usage[0][:time]}\"}," \
                    '{"v":354}]}]}'
    assert_equal(@gfx.export_as_google_api_format_frame(@gfx.gfxinfo_usage), expected_json)
  end

  def test_convert_to_google_data_api_format_frame_one_api_23
    dummy_array = %w(1926852 bytes 1.84 MB 21 views 31.36 kB of display lists Total frames rendered: 3 Janky frames: 2 (66.67%))
    @gfx.api_level = 23

    @gfx.store_gfxinfo_usage(dummy_array)
    expected_json = '{"cols":[{"label":"time","type":"string"},' \
                    '{"label":"frames_rendered","type":"number"},{"label":"janky_frame","type":"number"}],' \
                    "\"rows\":[{\"c\":[{\"v\":\"#{@gfx.gfxinfo_usage[0][:time]}\"},{\"v\":3},{\"v\":2}]}]}"
    assert_equal(@gfx.export_as_google_api_format_frame(@gfx.gfxinfo_usage), expected_json)
  end

  def test_convert_to_google_data_api_format_gfx_many
    dummy_array = %w[5781894 bytes 5.51 MB 465 views 38.00 kB of display lists 354 frames rendered 13:43:32.556]

    @gfx.store_gfxinfo_usage(dummy_array)
    @gfx.store_gfxinfo_usage(dummy_array)
    expected_json = '{"cols":[{"label":"time","type":"string"},' \
                    '{"label":"view","type":"number"},{"label":"display_lists_kb","type":"number"}],' \
                    "\"rows\":[{\"c\":[{\"v\":\"#{@gfx.gfxinfo_usage[1][:time]}\"},{\"v\":465},{\"v\":38.0}]}," \
                    "{\"c\":[{\"v\":\"#{@gfx.gfxinfo_usage[1][:time]}\"},{\"v\":465},{\"v\":38.0}]}]}"
    assert_equal(@gfx.export_as_google_api_format_gfx(@gfx.gfxinfo_usage), expected_json)
  end

  def test_convert_to_google_data_api_format_mem_many
    dummy_array = %w[5781894 bytes 5.51 MB 465 views 38.00 kB of display lists 354 frames rendered 13:43:32.556]

    @gfx.store_gfxinfo_usage(dummy_array)
    @gfx.store_gfxinfo_usage(dummy_array)
    expected_json = '{"cols":[{"label":"time","type":"string"},' \
                    "{\"label\":\"total_memory\",\"type\":\"number\"}],\"rows\":[{\"c\":[{\"v\":\"#{@gfx.gfxinfo_usage[1][:time]}\"}," \
                    "{\"v\":5646.38}]},{\"c\":[{\"v\":\"#{@gfx.gfxinfo_usage[1][:time]}\"},{\"v\":5646.38}]}]}"
    assert_equal(@gfx.export_as_google_api_format_mem(@gfx.gfxinfo_usage), expected_json)
  end

  def test_convert_to_google_data_api_format_frame_many
    dummy_array = %w[5781894 bytes 5.51 MB 465 views 38.00 kB of display lists 354 frames rendered 13:43:32.556]

    @gfx.store_gfxinfo_usage(dummy_array)
    @gfx.store_gfxinfo_usage(dummy_array)
    expected_json = '{"cols":[{"label":"time","type":"string"},' \
                    "{\"label\":\"frames_rendered\",\"type\":\"number\"}],\"rows\":[{\"c\":[{\"v\":\"#{@gfx.gfxinfo_usage[1][:time]}\"}," \
                    "{\"v\":354}]},{\"c\":[{\"v\":\"#{@gfx.gfxinfo_usage[1][:time]}\"},{\"v\":354}]}]}"
    assert_equal(@gfx.export_as_google_api_format_frame(@gfx.gfxinfo_usage), expected_json)
  end

  def test_convert_to_google_data_api_format_frame_many_api_23
    dummy_array = %w(1926852 bytes 1.84 MB 21 views 31.36 kB of display lists Total frames rendered: 3 Janky frames: 2 (66.67%))
    @gfx.api_level = 23

    @gfx.store_gfxinfo_usage(dummy_array)
    @gfx.store_gfxinfo_usage(dummy_array)
    expected_json = '{"cols":[{"label":"time","type":"string"},' \
                    '{"label":"frames_rendered","type":"number"},{"label":"janky_frame","type":"number"}],' \
                    "\"rows\":[{\"c\":[{\"v\":\"#{@gfx.gfxinfo_usage[1][:time]}\"}," \
                    "{\"v\":3},{\"v\":2}]},{\"c\":[{\"v\":\"#{@gfx.gfxinfo_usage[1][:time]}\"},{\"v\":3},{\"v\":2}]}]}"
    assert_equal(@gfx.export_as_google_api_format_frame(@gfx.gfxinfo_usage), expected_json)
  end
end
