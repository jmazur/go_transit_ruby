$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)
Dir[File.expand_path(File.join(File.dirname(__FILE__),'support','**','*.rb'))].each {|f| require f}
require "go_transit_ruby"
require "webmock"
require "json"
require "pry"
include WebMock::API

WebMock.disable_net_connect!(allow_localhost: true)
WebMock.enable!

RSpec.configure do |config|
  config.before(:each) do
    stub_request(:any, /api.openmetrolinx.com/).
      to_rack(FakeMetrolinx)
  end
end
