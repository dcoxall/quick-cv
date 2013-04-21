# encoding: utf-8
require "sinatra"
require "haml"
require "dalli"

class QuickCVApp < Sinatra::Application
  enable :sessions

  configure :production do
    set :haml, { ugly: true }
    set :clean_trace, true
    set :cache_client, Dalli::Client.new('localhost:11211')
  end

  configure :development do
    set :cache_client, Dalli::Client.new('localhost:11211')
  end
end

require_relative "models/init.rb"
require_relative "routes/init.rb"
