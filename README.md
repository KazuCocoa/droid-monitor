# Droid::Monitor

Monitoring Android apu or memory usage and create their simple graph with Google API.

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

See under `sample` file in this repository.

### CPU

```ruby
# initialize
@cpu = Droid::Monitor::Cpu.new( { package: "com.android.chrome" } )

# save data into @cpu.cpu_usage
@cpu.store_dumped_cpu_usage

# export data into filename as google api format
filename = "sample_data.txt"
@cpu.save_cpu_usage_as_google_api(filename)

# export data into filename which is used the above command.
output_file_path = "sample.html"
graph_opts = { title: "Example", header1: "this graph is just sample"}
@cpu.create_graph(filename, graph_opts, output_file_path)

```

#### Graph

![](https://github.com/KazuCocoa/droid-monitor/blob/master/doc/images/Screen%20Shot%202015-05-23%20at%2019.46.08.png)

### Memory

```ruby
# initialize
@memory = Droid::Monitor::Cpu.new( { package: "com.android.chrome" } )

# save data into @memory.memory_usage
@memory.store_dumped_memory_details_usage

# export data into filename as google api format
filename = "sample_data.txt"
@memory.save_memory_details_as_google_api(filename)

# export data into filename which is used the above command.
output_file_path = "sample.html"
graph_opts = { title: "Example", header1: "this graph is just sample"}
@cpu.create_graph(filename, graph_opts, output_file_path)
```

#### Graph

![](https://github.com/KazuCocoa/droid-monitor/blob/master/doc/images/Screen%20Shot%202015-05-23%20at%2019.56.41.png)


## Contributing

1. Fork it ( https://github.com/[my-github-username]/droid-monitor/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
