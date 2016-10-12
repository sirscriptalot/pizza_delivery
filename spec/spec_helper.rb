require 'minitest/autorun'
require_relative '../lib/postal'

def context(*args, &block)
  describe(*args, &block)
end
