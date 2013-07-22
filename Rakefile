require 'bundler/gem_tasks'
require 'rubygems/package_task'

Dir[File.expand_path('../*gemspec', __FILE__)].reverse.each do |gemspec_path|
  gemspec = eval(IO.read(gemspec_path))
  Gem::PackageTask.new(gemspec).define
end

task :default, :gem