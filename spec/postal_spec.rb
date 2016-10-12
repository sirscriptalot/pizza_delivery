require_relative './spec_helper'

class Handler
  include Postal::Handler

  attr_reader :status, :message

  def initialize
    @status, @message = nil, nil
  end

  def receive(status, message)
    @status, @message = status, message
  end
end

class Service < Postal::Service
  def call
    deliver :status, {}
  end
end

describe Postal::Handler do
  describe '#handle' do
    before do
      @handler = Handler.new
    end

    context 'callback is a symbol' do
      it 'responds to service with callback' do
        @handler.status.must_be_nil
        @handler.message.must_be_nil

        @handler.handle Service, :receive

        @handler.status.wont_be_nil
        @handler.message.wont_be_nil
      end
    end

    context 'callback is a string' do
      it 'responds to service with callback' do
        @handler.status.must_be_nil
        @handler.message.must_be_nil

        @handler.handle Service, "receive"

        @handler.status.wont_be_nil
        @handler.message.wont_be_nil
      end
    end
  end
end

describe Postal::Service do
  describe '#call' do
    it 'must be implemented by subclass' do
      lambda { Postal::Service.new(nil, nil).call }.must_raise NotImplementedError
    end
  end

  describe '#deliver' do
    it 'calls handler callback with status, message' do
      handler = Handler.new
      service = Service.new(handler, :receive)
      status = :status
      message = { foo: :bar }
      service.deliver status, message

      handler.status.must_equal status
      handler.message.must_equal message
    end
  end
end
