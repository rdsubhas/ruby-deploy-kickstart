require 'sinatra'
require 'sinatra/reloader' if development?
require 'rack-mini-profiler' if development?
require 'json'

class Myapp < Sinatra::Base

  configure :development do
    # Enable hot reloading in development mode
    register Sinatra::Reloader
    use Rack::MiniProfiler
  end

  # Enable request logging
  set :logging, true

  # If you're planning to proxy behind nginx,
  # Then you can move this bind inside `configure :development`
  set :bind, '0.0.0.0'

  # A simple endpoint
  get '/' do
    config = ENV.select{ |k,v| k =~ /^MYAPP_/ }
    return "Running with config: #{config.inspect}"
  end

end
