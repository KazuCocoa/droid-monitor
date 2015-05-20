require 'test/unit'

require './lib/droid/monitor/memory'

SAMPLE_DATA_43 = <<-EOS
Applications Memory Usage (kB):
Uptime: 69627589 Realtime: 376894346

** MEMINFO in pid 29607 [com.sample.package] **
                         Shared  Private     Heap     Heap     Heap
                   Pss    Dirty    Dirty     Size    Alloc     Free
                ------   ------   ------   ------   ------   ------
       Native       24        8       24    11296     7927      408
       Dalvik    11976     4696    11916    13388     7454     5934
       Cursor        0        0        0
       Ashmem        0        0        0
    Other dev       56       56        0
     .so mmap     2507     2028      620
    .jar mmap        0        0        0
    .apk mmap       49        0        0
    .ttf mmap        3        0        0
    .dex mmap      628        0       12
   Other mmap      592       16      296
      Unknown    13094      504    13092
        TOTAL    28929     7308    25960    24684    15381     6342

 Objects
               Views:      115         ViewRootImpl:        1
         AppContexts:        6           Activities:        1
              Assets:        6        AssetManagers:        6
       Local Binders:       15        Proxy Binders:       23
    Death Recipients:        0
     OpenSSL Sockets:        3

 SQL
         MEMORY_USED:      462
  PAGECACHE_OVERFLOW:       83          MALLOC_SIZE:       62

 DATABASES
      pgsz     dbsz   Lookaside(b)          cache  Dbname
         4       48             37        11/22/4  /data/data/com.sample.package/databases/sample.db
EOS

SAMPLE_DATA_44 = <<-EOS
Applications Memory Usage (kB):
Uptime: 76485937 Realtime: 238763696

** MEMINFO in pid 30125 [com.sample.package] **
                   Pss  Private  Private  Swapped     Heap     Heap     Heap
                 Total    Dirty    Clean    Dirty     Size    Alloc     Free
                ------   ------   ------   ------   ------   ------   ------
  Native Heap        0        0        0        0     8948     8520      271
  Dalvik Heap    23195    22764        0        0    31772    29998     1774
 Dalvik Other     3875     3820        0        0
        Stack      272      272        0        0
       Cursor        4        4        0        0
    Other dev     4014     3136       20        0
     .so mmap     1429     1028       12        0
    .apk mmap      712        0      368        0
    .ttf mmap      594        0      308        0
    .dex mmap     5099       44     4648        0
   Other mmap       40        4       16        0
      Unknown     5329     5324        0        0
        TOTAL    44563    36396     5372        0    40720    38518     2045

 Objects
               Views:      690         ViewRootImpl:        1
         AppContexts:        3           Activities:        1
              Assets:        4        AssetManagers:        4
       Local Binders:       15        Proxy Binders:       23
    Death Recipients:        1
     OpenSSL Sockets:        7

 SQL
         MEMORY_USED:      329
  PAGECACHE_OVERFLOW:       82          MALLOC_SIZE:       62

 DATABASES
      pgsz     dbsz   Lookaside(b)          cache  Dbname
         4       20             58        21/26/9  /data/data/com.sample.package/databases/sample.db
 Asset Allocations
    zip:/data/app/com.sample.package.apk:/assets/sample.ttf: 132K
EOS

class MemoryTest < Test::Unit::TestCase

  def setup
    @memory = Droid::Monitor::Memory.new("com.android.chrome", "")
  end

  def teardown
    @memory = nil
  end

  def test_initialize
    assert_instance_of(Droid::Monitor::Memory, @memory)

    @memory.api_level = 19
    assert_equal("com.android.chrome", @memory.package)
    assert_equal("", @memory.device_serial)
    assert_equal(19, @memory.api_level)
    assert_equal([], @memory.memory_usage)
    assert_equal([], @memory.memory_detail_usage)
  end

  def test_push_current_time
    assert_equal(@memory.push_current_time([]).length, 1)
  end

  def test_dump_memory_usage_under_api_level18
    expected = %w(Uptime: 69627589 Realtime: 376894346)
    assert_equal(expected,@memory.dump_memory_usage(SAMPLE_DATA_43))
  end

  def test_dump_memory_usage_over_api_level18
    expected = %w(Uptime: 76485937 Realtime: 238763696)
    assert_equal(expected,@memory.dump_memory_usage(SAMPLE_DATA_44))
  end

  def test_dump_memory_detail_usage_under_api_level18
    expected = %w(TOTAL 28929 7308 25960 24684 15381 6342)
    assert_equal(expected,@memory.dump_memory_details_usage(SAMPLE_DATA_43))
  end

  def test_dump_memory_detail_usage_over_api_level18
    expected = %w(TOTAL 44563 36396 5372 0 40720 38518 2045)
    assert_equal(expected,@memory.dump_memory_details_usage(SAMPLE_DATA_44))
  end
end