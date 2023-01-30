$LOAD_PATH.unshift(::File.join(::File.dirname(__FILE__), "lib"))

require "go_transit_ruby/version"

Gem::Specification.new do |s|
  s.name = "go_transit_ruby"
  s.version = GoTransit::VERSION
  s.required_ruby_version = ">= 2.3.0"
  s.summary = "Ruby Interface for the Go Transit API"
  s.author = "Justin Mazur"
  s.homepage = "https://github.com/jmazur/go_transit_ruby"
  s.license = "MIT"
  s.executables   = s.files.grep(%r{^bin/}) { |f| File.basename(f) }
  s.test_files    = s.files.grep(%r{^(test|spec|features)/})
  s.require_paths = ["lib"]

  s.add_dependency "activesupport"

  s.add_development_dependency "bundler"
  s.add_development_dependency "rake"
  s.add_development_dependency "rspec"
  s.add_development_dependency "pry"
  s.add_development_dependency "sinatra"
  s.add_development_dependency "webmock"
end
