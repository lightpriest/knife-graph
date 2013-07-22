$:.push File.expand_path('../lib', __FILE__)
require 'knife-graph/version'

Gem::Specification.new do |s|
  s.name        = 'knife-graph'
  s.version     = Knife::Graph::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ['Or Cohen']
  s.email       = ['orc@fewbytes.com']
  s.homepage    = 'https://github.com/fewbytes/knife-graph'
  s.summary     = %q{Plugin that exports Chef installations structure in a graph}
  s.description = s.summary

  s.add_dependency 'graph'
  s.add_dependency 'mixlib-shellout'

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end