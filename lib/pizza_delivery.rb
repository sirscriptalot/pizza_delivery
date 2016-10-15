require_relative './pizza_delivery/version'

module PizzaDelivery
  module Caller
    def call(service_class, callback, *args)
      service_class.new(self, callback).call(*args)
    end
  end

  class Service
    attr_reader :caller_instance, :callback

    def initialize(caller_instance, callback)
      @caller_instance = caller_instance
      @callback = callback
    end

    def call
      raise NotImplementedError, 'abstract'
    end

    def deliver(status, payload)
      caller_instance.send(callback, status, payload)
    end
  end
end
