# encoding: utf-8

unless defined?(Motion::Project::Config)
  raise 'This file must be required within a RubyMotion Rakefile'
end

# To compile with RubyMotion we must stub out `require` and `require_relative`
# and instead add files in `App.setup`.

def require(*args); end
def require_relative(*args); end

lib = File.dirname(File.expand_path(__FILE__))

Motion::Project::App.setup do |app|
  app.files.unshift(File.join(File.dirname(__FILE__), 'postal.rb'))
end
