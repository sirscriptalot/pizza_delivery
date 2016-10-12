module Postal
  VERSION = '0.1.0'.freeze

  module Handler
    def handle(service_class, callback, *args)
      service_class.new(self, callback, *args).call
    end
  end

  class Service
    attr_reader :handler, :callback

    def initialize(handler, callback, *args)
      @handler = handler
      @callback = callback
      @args = args
    end

    def call
      raise NotImplementedError, 'abstract'
    end

    def deliver(status, message)
      handler.send(callback, status, message)
    end
  end
end
