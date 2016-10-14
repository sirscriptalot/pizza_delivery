require_relative './pizza_delivery/version'

module PizzaDelivery
  module Caller
    def call(service_class, callback, *args)
      service_class.new(self, callback, *args).call
    end
  end

  class Service
    attr_reader :caller, :callback

    def initialize(caller, callback, *args)
      @caller = caller
      @callback = callback
      @args = args
    end

    def call
      raise NotImplementedError, 'abstract'
    end

    def deliver(status, payload)
      caller.send(callback, status, payload)
    end
  end
end
