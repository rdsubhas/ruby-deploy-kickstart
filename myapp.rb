require 'sinatra'
require 'sinatra/reloader' if development?
require 'rack-mini-profiler' if development?
require 'json'

class Myapp < Sinatra::Base
  configure :development do
    set :bind, '0.0.0.0'
    set :logging, true
    
    register Sinatra::Reloader
    use Rack::MiniProfiler
  end

  get '/' do
    config = ENV.select{ |k,v| k =~ /^MYAPP_/ }
    return "Running with config: #{config.inspect}"
  end
end
