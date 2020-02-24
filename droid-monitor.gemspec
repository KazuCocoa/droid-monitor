# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'droid/monitor/version'

Gem::Specification.new do |spec|
  spec.name          = 'droid-monitor'
  spec.version       = Droid::Monitor::VERSION
  spec.authors       = ['Kazuaki MATSUO']
  spec.email         = ['fly.49.89.over@gmail.com']
  spec.summary       = 'Monitoring Android cpu or memory usage and create their simple graph with Google API.'
  spec.description   = 'Monitoring connected Android devices via adb command. And you can create simple http graph wth Google API.'
  spec.homepage      = 'https://github.com/KazuCocoa/droid-monitor'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']
  spec.required_ruby_version = '>= 2.3'

  spec.add_dependency 'faml', '~> 0.8'
  spec.add_dependency 'haml', '~> 5.0' # for using faml to tilt
  spec.add_dependency 'tilt', '~> 2.0'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rubocop', '0.80.0'
  spec.add_development_dependency 'test-unit'
end
