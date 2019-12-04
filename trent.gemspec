version = File.read("Versionfile")
require 'date'

Gem::Specification.new do |s|
  s.name        = 'trent'
  s.version     = version
  s.date        = Date.today.to_s
  s.summary     = 'Run and debug bash commands on Travis-CI much easier.'
  s.description = 'I have been using Travis-CI for a few years to build, test, and deploy my apps. Bash is great, but using a higher level language for interacting with Travis and the build machine would be very beneficial. 

  Trent is a convenient ruby gem that helps you execute system shell scripts with as little code *and pain* as possible.'
  s.authors     = ['Levi Bostian']
  s.email       = 'levi.bostian@gmail.com'
  s.files       = Dir.glob('{bin,lib}/**/*') + %w[LICENSE README.md CHANGELOG.md]
  s.homepage    = 'http://github.com/levibostian/trent'
  s.license = 'MIT'
  s.add_runtime_dependency 'colorize', '~> 0.8', '>= 0.8.1'
  s.add_runtime_dependency 'net-ssh', '~> 5.0', '>= 5.0.2'
  s.add_runtime_dependency 'travis', '~> 1.8', '>= 1.8.2'
  s.add_development_dependency 'rubocop', '~> 0.58', '>= 0.58.2'
  s.add_development_dependency 'rake', '~> 12.3', '>= 12.3.1'
  s.add_development_dependency 'rspec', '~> 3.8', '>= 3.8.0'
  s.add_development_dependency 'rspec_junit_formatter', '~> 0.4', '>= 0.4.1'
end
