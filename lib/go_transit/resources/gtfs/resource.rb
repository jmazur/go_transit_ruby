module GoTransit
  class Gtfs::Resource < ApiResource
    def self.hydrate_as(classes)
      own_classes.merge!(classes)
    end

    def self.own_classes
      @own_classes ||= {}
    end

    def self.class_for(key)
      own_classes[key.to_sym] || (superclass.class_for(key) if superclass.respond_to?(:class_for))
    end

    def self.epoch_time(*fields)
      fields.each do |field|
        define_method("#{field}_utc") { epoch_utc(public_send(field)) }
        define_method("#{field}_local") { epoch_local(public_send(field)) }
      end
    end

    private

    def get_klass(name)
      self.class.class_for(name) || raise(NameError, "#{self.class.name} has no class for #{name.inspect}")
    end

    def wrapped_collection?(_value)
      false
    end

    def epoch_utc(epoch)
      Time.at(epoch).utc if epoch
    end

    def epoch_local(epoch, timezone: Zone::DEFAULT)
      Zone.epoch_to_local(epoch, timezone) if epoch
    end
  end
end
