module GoTransit
  class ServiceUpdate::Message::Stop < ApiResource
    attr_accessor :code, :name
  end
end