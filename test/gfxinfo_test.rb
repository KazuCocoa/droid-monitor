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

# 8 is same as OS 7
SAMPLE_GFXINFO_7 = <<~EOS
  Applications Graphics Acceleration Info:
  Uptime: 6897124 Realtime: 6897124

  ** Graphics info for pid 3015 [com.android.settings] **

  Stats since: 6839009800620ns
  Total frames rendered: 24
  Janky frames: 14 (58.33%)
  50th percentile: 19ms
  90th percentile: 65ms
  95th percentile: 150ms
  99th percentile: 300ms
  Number Missed Vsync: 3
  Number High input latency: 0
  Number Slow UI thread: 5
  Number Slow bitmap uploads: 1
  Number Slow issue draw commands: 12
  HISTOGRAM: 5ms=1 6ms=0 7ms=1 8ms=0 9ms=2 10ms=1 11ms=1 12ms=3 13ms=0 14ms=0 15ms=1 16ms=0 17ms=0 18ms=0 19ms=3 20ms=0 21ms=0 22ms=0 23ms=0 24ms=1 25ms=1 26ms=2 27ms=1 28ms=1 29ms=0 30ms=0 31ms=0 32ms=1 34ms=0 36ms=0 38ms=0 40ms=0 42ms=0 44ms=0 46ms=0 48ms=0 53ms=1 57ms=0 61ms=0 65ms=1 69ms=0 73ms=0 77ms=0 81ms=0 85ms=0 89ms=0 93ms=0 97ms=0 101ms=0 105ms=0 109ms=0 113ms=0 117ms=0 121ms=0 125ms=0 129ms=0 133ms=0 150ms=1 200ms=0 250ms=0 300ms=1 350ms=0 400ms=0 450ms=0 500ms=0 550ms=0 600ms=0 650ms=0 700ms=0 750ms=0 800ms=0 850ms=0 900ms=0 950ms=0 1000ms=0 1050ms=0 1100ms=0 1150ms=0 1200ms=0 1250ms=0 1300ms=0 1350ms=0 1400ms=0 1450ms=0 1500ms=0 1550ms=0 1600ms=0 1650ms=0 1700ms=0 1750ms=0 1800ms=0 1850ms=0 1900ms=0 1950ms=0 2000ms=0 2050ms=0 2100ms=0 2150ms=0 2200ms=0 2250ms=0 2300ms=0 2350ms=0 2400ms=0 2450ms=0 2500ms=0 2550ms=0 2600ms=0 2650ms=0 2700ms=0 2750ms=0 2800ms=0 2850ms=0 2900ms=0 2950ms=0 3000ms=0 3050ms=0 3100ms=0 3150ms=0 3200ms=0 3250ms=0 3300ms=0 3350ms=0 3400ms=0 3450ms=0 3500ms=0 3550ms=0 3600ms=0 3650ms=0 3700ms=0 3750ms=0 3800ms=0 3850ms=0 3900ms=0 3950ms=0 4000ms=0 4050ms=0 4100ms=0 4150ms=0 4200ms=0 4250ms=0 4300ms=0 4350ms=0 4400ms=0 4450ms=0 4500ms=0 4550ms=0 4600ms=0 4650ms=0 4700ms=0 4750ms=0 4800ms=0 4850ms=0 4900ms=0 4950ms=0
  Caches:
  Current memory usage / total memory usage (bytes):
    TextureCache           158760 / 49766400
    Layers total          0 (numLayers = 0)
    RenderBufferCache           0 /  4147200
    GradientCache               0 /  1048576
    PathCache                   0 /  8294400
    TessellationCache         744 /  1048576
    TextDropShadowCache         0 /  4147200
    PatchCache                  0 /   131072
    FontRenderer A8         44451 /  1183744
      A8   texture 0        44451 /  1183744
    FontRenderer RGBA           0 /        0
    FontRenderer total      44451 /  1183744
  Other:
    FboCache                    0 /        0
  Total memory usage:
    1343248 bytes, 1.28 MB


  Pipeline=FrameBuilder
  Profile data in ms:

    com.android.settings/com.android.settings.Settings/android.view.ViewRootImpl@859603c (visibility=0)
  View hierarchy:

    com.android.settings/com.android.settings.Settings/android.view.ViewRootImpl@859603c
    66 views, 95.10 kB of display lists


  Total ViewRootImpl: 1
  Total Views:        66
  Total DisplayList:  95.10 kB
EOS

SAMPLE_GFXINFO_9 = <<~EOS
  Applications Graphics Acceleration Info:
  Uptime: 101387804 Realtime: 236632184

  ** Graphics info for pid 2720 [com.android.chrome] **

  Stats since: 101382312046230ns
  Total frames rendered: 43
  Janky frames: 7 (16.28%)
  50th percentile: 5ms
  90th percentile: 69ms
  95th percentile: 150ms
  99th percentile: 200ms
  Number Missed Vsync: 5
  Number High input latency: 14
  Number Slow UI thread: 5
  Number Slow bitmap uploads: 0
  Number Slow issue draw commands: 1
  Number Frame deadline missed: 5
  HISTOGRAM: 5ms=33 6ms=1 7ms=0 8ms=0 9ms=0 10ms=1 11ms=1 12ms=0 13ms=0 14ms=0 15ms=0 16ms=0 17ms=0 18ms=0 19ms=0 20ms=0 21ms=0 22ms=0 23ms=0 24ms=0 25ms=0 26ms=0 27ms=1 28ms=0 29ms=0 30ms=1 31ms=0 32ms=0 34ms=0 36ms=0 38ms=0 40ms=0 42ms=0 44ms=0 46ms=0 48ms=0 53ms=0 57ms=0 61ms=0 65ms=0 69ms=1 73ms=0 77ms=0 81ms=0 85ms=1 89ms=0 93ms=0 97ms=0 101ms=0 105ms=0 109ms=0 113ms=0 117ms=0 121ms=0 125ms=0 129ms=0 133ms=0 150ms=1 200ms=2 250ms=0 300ms=0 350ms=0 400ms=0 450ms=0 500ms=0 550ms=0 600ms=0 650ms=0 700ms=0 750ms=0 800ms=0 850ms=0 900ms=0 950ms=0 1000ms=0 1050ms=0 1100ms=0 1150ms=0 1200ms=0 1250ms=0 1300ms=0 1350ms=0 1400ms=0 1450ms=0 1500ms=0 1550ms=0 1600ms=0 1650ms=0 1700ms=0 1750ms=0 1800ms=0 1850ms=0 1900ms=0 1950ms=0 2000ms=0 2050ms=0 2100ms=0 2150ms=0 2200ms=0 2250ms=0 2300ms=0 2350ms=0 2400ms=0 2450ms=0 2500ms=0 2550ms=0 2600ms=0 2650ms=0 2700ms=0 2750ms=0 2800ms=0 2850ms=0 2900ms=0 2950ms=0 3000ms=0 3050ms=0 3100ms=0 3150ms=0 3200ms=0 3250ms=0 3300ms=0 3350ms=0 3400ms=0 3450ms=0 3500ms=0 3550ms=0 3600ms=0 3650ms=0 3700ms=0 3750ms=0 3800ms=0 3850ms=0 3900ms=0 3950ms=0 4000ms=0 4050ms=0 4100ms=0 4150ms=0 4200ms=0 4250ms=0 4300ms=0 4350ms=0 4400ms=0 4450ms=0 4500ms=0 4550ms=0 4600ms=0 4650ms=0 4700ms=0 4750ms=0 4800ms=0 4850ms=0 4900ms=0 4950ms=0
  Font Cache (CPU):
    Size: 17.95 kB
    Glyph Count: 10
  CPU Caches:
  GPU Caches:
    Other:
      Buffer Object: 63.00 KB (2 entries)
    Image:
      Texture: 77.68 KB (6 entries)
    Scratch:
      Buffer Object: 64.00 KB (2 entries)
      RenderTarget: 272.00 KB (1 entry)
      Texture: 1.00 MB (1 entry)
  Other Caches:
                           Current / Maximum
    VectorDrawableAtlas    0.00 kB /   0.00 KB (entries = 0)
    Layers Total           0.00 KB (numLayers = 0)
  Total GPU memory usage:
    1536700 bytes, 1.47 MB (476.68 KB is purgeable)


  Pipeline=Skia (OpenGL)

  Layout Cache Info:
    Usage: 14/5000 entries
    Hit ratio: 147/162 (0.907407)
  Profile data in ms:

    com.android.chrome/com.google.android.apps.chrome.Main/android.view.ViewRootImpl@e39dbee (visibility=0)
  View hierarchy:

    com.android.chrome/com.google.android.apps.chrome.Main/android.view.ViewRootImpl@e39dbee
    59 views, 51.84 kB of display lists


  Total ViewRootImpl: 1
  Total Views:        59
  Total DisplayList:  51.84 kB
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
    expected = %w[654464 bytes, 0.62 MB 41 views, 1.36 kB of display lists, 191 frames rendered] # rubocop:disable Lint/PercentStringArray

    assert_equal(expected, @gfx.dump_gfxinfo_usage(SAMPLE_GFXINFO))
  end

  def test_dump_gfxinfo_usage_for_API21 # rubocop:disable Naming/MethodName
    expected = %w[1194548 bytes, 1.14 MB 55 views, 51,03 kB of display lists] # rubocop:disable Lint/PercentStringArray

    assert_equal(expected, @gfx.dump_gfxinfo_usage(SAMPLE_GFXINFO_5))
  end

  def test_dump_gfxinfo_usage_for_API23 # rubocop:disable Naming/MethodName
    expected = %w(1926852 bytes, 1.84 MB 21 views, 31.36 kB of display lists Total frames rendered: 3 Janky frames: 2 (66.67%)) # rubocop:disable Lint/PercentStringArray
    @gfx.api_level = 23
    assert_equal(expected, @gfx.dump_gfxinfo_usage(SAMPLE_GFXINFO_6))
  end

  def test_dump_gfxinfo_usage_for_OS24 # rubocop:disable Naming/MethodName
    expected = %w(1343248 bytes, 1.28 MB 66 views, 95.10 kB of display lists Total frames rendered: 24 Janky frames: 14 (58.33%)) # rubocop:disable Lint/PercentStringArray
    @gfx.api_level = 24
    assert_equal(expected, @gfx.dump_gfxinfo_usage(SAMPLE_GFXINFO_7))
  end

  def test_dump_gfxinfo_usage_for_OS28 # rubocop:disable Naming/MethodName
    expected = %w(1536700 bytes, 1.47 MB 59 views, 51.84 kB of display lists Total frames rendered: 43 Janky frames: 7 (16.28%)) # rubocop:disable Lint/PercentStringArray
    @gfx.api_level = 28
    assert_equal(expected, @gfx.dump_gfxinfo_usage(SAMPLE_GFXINFO_9))
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
