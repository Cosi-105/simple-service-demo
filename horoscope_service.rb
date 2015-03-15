require 'sinatra'
require 'sinatra/activerecord'
require 'pry'
require 'pry-byebug'
require_relative './models/fortune'

class HoroscopeService < Sinatra::Base

  configure do
    env = ENV["SINATRA_ENV"] || "development"
    databases = YAML.load_file("config/database.yml") 
    ActiveRecord::Base.establish_connection(databases[env])
  end

  get '/fortune/:date/:sign/' do
    @f = Fortune.offset(rand(Fortune.count)).take
    @f.fortune.to_json
  end
end