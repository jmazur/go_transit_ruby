$LOAD_PATH.unshift(::File.join(::File.dirname(__FILE__), "lib"))

require "go_transit/version"

Gem::Specification.new do |s|
  s.name = "go_transit"
  s.version = GoTransit::VERSION
  s.required_ruby_version = ">= 2.7.0"
  s.summary = "Ruby Interface for the Go Transit API"
  s.author = "Justin Mazur"
  s.homepage = "https://github.com/jmazur/go_transit_ruby"
  s.license = "MIT"
  s.files = Dir["lib/**/*"]
  s.require_paths = ["lib"]

  s.add_dependency "activesupport"

  s.add_development_dependency "bundler"
  s.add_development_dependency "rake"
  s.add_development_dependency "rspec"
  s.add_development_dependency "pry"
  s.add_development_dependency "sinatra"
  s.add_development_dependency "webmock"
  s.add_development_dependency "simplecov"
  s.add_development_dependency "timecop"
end
