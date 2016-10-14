require_relative './spec_helper'

class Caller
  include PizzaDelivery::Caller

  attr_reader :status, :payload

  def initialize
    @status, @payload = nil, nil
  end

  def receive(status, payload)
    @status, @payload = status, payload
  end
end

class Service < PizzaDelivery::Service
  def call
    deliver :status, {}
  end
end

describe PizzaDelivery::Caller do
  describe '#call' do
    before do
      @caller_instance = Caller.new
    end

    context 'callback is a symbol' do
      it 'responds to service with callback' do
        @caller_instance.status.must_be_nil
        @caller_instance.payload.must_be_nil

        @caller_instance.call Service, :receive

        @caller_instance.status.wont_be_nil
        @caller_instance.payload.wont_be_nil
      end
    end

    context 'callback is a string' do
      it 'responds to service with callback' do
        @caller_instance.status.must_be_nil
        @caller_instance.payload.must_be_nil

        @caller_instance.call Service, "receive"

        @caller_instance.status.wont_be_nil
        @caller_instance.payload.wont_be_nil
      end
    end
  end
end

describe PizzaDelivery::Service do
  describe '#call' do
    it 'must be implemented by subclass' do
      lambda { PizzaDelivery::Service.new(nil, nil).call }.must_raise NotImplementedError
    end
  end

  describe '#deliver' do
    it 'calls caller_instance callback with status, payload' do
      caller_instance = Caller.new
      service = Service.new(caller_instance, :receive)
      status = :status
      payload = { foo: :bar }
      service.deliver status, payload

      caller_instance.status.must_equal status
      caller_instance.payload.must_equal payload
    end
  end
end
