require 'sinatra'
require 'sinatra/activerecord'
require 'erb'
require_relative './models/fortune'

class HoroscopeService < Sinatra::Base

  configure do
    env = ENV["SINATRA_ENV"] || "development"
    databases = YAML.load(ERB.new(File.read("config/database.yml")).result)
    puts databases
    ActiveRecord::Base.establish_connection(databases[env])
  end

  get '/fortune/:date/:sign/' do 
    @f = Fortune.offset(rand(Fortune.count)).take
    @f.fortune.to_json
  end
end