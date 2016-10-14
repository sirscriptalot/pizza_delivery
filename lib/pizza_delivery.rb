require_relative './pizza_delivery/version'

module PizzaDelivery
  module Caller
    def call(service_class, callback, *args)
      service_class.new(self, callback, *args).call
    end
  end

  class Service
    attr_reader :caller_instance, :callback

    def initialize(caller_instance, callback, *args)
      @caller_instance = caller_instance
      @callback = callback
      @args = args
    end

    def call
      raise NotImplementedError, 'abstract'
    end

    def deliver(status, payload)
      caller_instance.send(callback, status, payload)
    end
  end
end
