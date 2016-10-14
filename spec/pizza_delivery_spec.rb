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
      @caller = Caller.new
    end

    context 'callback is a symbol' do
      it 'responds to service with callback' do
        @caller.status.must_be_nil
        @caller.payload.must_be_nil

        @caller.call Service, :receive

        @caller.status.wont_be_nil
        @caller.payload.wont_be_nil
      end
    end

    context 'callback is a string' do
      it 'responds to service with callback' do
        @caller.status.must_be_nil
        @caller.payload.must_be_nil

        @caller.call Service, "receive"

        @caller.status.wont_be_nil
        @caller.payload.wont_be_nil
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
    it 'calls caller callback with status, payload' do
      caller = Caller.new
      service = Service.new(caller, :receive)
      status = :status
      payload = { foo: :bar }
      service.deliver status, payload

      caller.status.must_equal status
      caller.payload.must_equal payload
    end
  end
end
