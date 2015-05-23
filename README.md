# Droid::Monitor

TODO: Write a gem description

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'droid-monitor'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install droid-monitor

## Usage
### CPU

```ruby
# initialize
@cpu = Droid::Monitor::Cpu.new("com.android.chrome", "")

# save data into @cpu.cpu_usage
@cpu.store_cpu_usage(@cpu.dump_cpu_usage(@cpu.dump_cpuinfo))

# export data into filename as google api format
filename = "sample_data.txt"
@cpu.save_cpu_usage_as_google_api(filename)

# export data into filename which is used the above command.
output_file_path = "sample.html"
@cpu.create_grapsh("Sample Grash", "this graph is just sampple", filename, default_setting, output_file_path)

```

### Memory

```ruby
# initialize
@memory = Droid::Monitor::Memory.new("com.android.chrome", "")

# save data into @memory.memory_usage
@memory.push_to_memory_details_usage(@memory.dump_memory_details_usage(@memory.dump_meminfo))

# export data into filename as google api format
filename = "sample_data.txt"
@memory.save_memory_details_as_google_api(filename)

# export data into filename which is used the above command.
output_file_path = "sample.html"
@memory.create_grapsh("Sample Grash", "this graph is just sampple", filename, default_setting, output_file_path)
```


## Contributing

1. Fork it ( https://github.com/[my-github-username]/droid-monitor/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
