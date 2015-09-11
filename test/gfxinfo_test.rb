require 'test/unit'

require './lib/droid/monitor/gfxinfo'

SAMPLE_GFXINFO = <<-EOS
Applications Graphics Acceleration Info:
Uptime: 3405482 Realtime: 3405477

** Graphics info for pid 18033 [com.android.chrome] **

Recent DisplayList operations
                    DrawDisplayList
                      DrawDisplayList
                      DrawDisplayList
                        DrawPatch
                        Save
                        ClipRect
                        DrawDisplayList
                          DrawDisplayList
                            Save
                            ClipRect
                            DrawDisplayList
                            DrawDisplayList
                            RestoreToCount
                          DrawDisplayList
                            DrawDisplayList
                              DrawRect
                          DrawDisplayList
                            Save
                            ClipRect
                            DrawDisplayList
                            DrawDisplayList
                            RestoreToCount
                          DrawDisplayList
                            DrawDisplayList
                              DrawRect
                          DrawDisplayList
                            Save
                            ClipRect
                            DrawDisplayList
                            DrawDisplayList
                            RestoreToCount
                          DrawDisplayList
                          DrawDisplayList
                        DrawDisplayList
                        RestoreToCount
      RestoreToCount
      Save
      ClipRect
      DrawDisplayList
        DrawDisplayList
        DrawDisplayList
      RestoreToCount
  DrawDisplayList
  DrawPatch
DrawRect
multiDraw
  DrawPatch
DrawRect
DrawRect
DrawRect

Caches:
Current memory usage / total memory usage (bytes):
  TextureCache          4550100 / 25165824
  LayerCache                  0 / 16777216
  RenderBufferCache           0 /  2097152
  GradientCache               0 /   524288
  PathCache              667506 / 10485760
  TextDropShadowCache         0 /  2097152
  PatchCache              40000 /   131072
  FontRenderer 0 A8      524288 /   524288
  FontRenderer 0 RGBA         0 /        0
  FontRenderer 0 total   524288 /   524288
Other:
  FboCache                    0 /       16
Total memory usage:
  5781894 bytes, 5.51 MB

Profile data in ms:

  com.android.chrome/com.android.chrome.MainActivity/android.view.ViewRootImpl@41f942c0
View hierarchy:

  com.android.chrome/com.android.chrome.MainActivity/android.view.ViewRootImpl@41f942c0
  465 views, 38.00 kB of display lists, 354 frames rendered


Total ViewRootImpl: 1
Total Views:        465
Total DisplayList:  38.00 kB
EOS

class GfxinfoTest < Test::Unit::TestCase

  def setup
    @gfx = Droid::Monitor::Gfxinfo.new( { package: "com.android.chrome" } )
  end

  def teardown
    @gfx = nil
  end

  # adb command
  # $ adb shell dumpsys gfxinfo com.android.chrome
  # def test_initialize
  # end

  def test_dump_gfxinfo_usage
    expected = %w(465 views, 38.00 kB of display lists,  354 frames rendered 5781894 bytes, 5.51 MB)
    assert_equal(expected, @gfx.dump_gfxinfo_usage(SAMPLE_GFXINFO))
  end

end
