Dir[File.expand_path(File.join(File.dirname(__FILE__),'support','**','*.rb'))].
  each {|f| require f}

require "go_transit"
require "webmock"
require "json"
require "pry"
require "simplecov"
require "timecop"
require "active_support"
include WebMock::API

WebMock.disable_net_connect!(allow_localhost: true)
WebMock.enable!

SimpleCov.start

RSpec.configure do |config|
  config.before(:each) do
    stub_request(:any, /api.openmetrolinx.com/).
      to_rack(FakeMetrolinx)
    stub_request(:any, /example.com/).
      to_rack(FakeMetrolinx)
  end
end
