require_relative './lib/postal'

Gem::Specification.new do |s|
  s.name = 'postal'
  s.summary = 'Postal'
  s.version = Postal::VERSION
  s.authors = ['Steve Weiss']
  s.email = ['weissst@mail.gvsu.edu']
  s.homepage = 'https://github.com/sirscriptalot/postal'
  s.license = 'MIT'
  s.files = `git ls-files`.split("\n")
end
