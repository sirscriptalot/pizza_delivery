require_relative './lib/pizza_delivery/version'

Gem::Specification.new do |s|
  s.name = 'pizza_delivery'
  s.summary = 'Pizza Delivery'
  s.version = PizzaDelivery::VERSION
  s.authors = ['Steve Weiss']
  s.email = ['weissst@mail.gvsu.edu']
  s.homepage = 'https://github.com/sirscriptalot/pizza_delivery'
  s.license = 'MIT'
  s.files = `git ls-files`.split("\n")
end
