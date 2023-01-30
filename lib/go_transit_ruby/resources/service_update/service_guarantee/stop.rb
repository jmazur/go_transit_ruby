module GoTransit
  class ServiceUpdate::ServiceGuarantee::Stop < ApiResource
    attr_accessor :code, :scope, :reason_en, :reason_fr
  end
end