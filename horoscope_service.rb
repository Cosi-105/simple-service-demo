require 'sinatra'
require 'sinatra/activerecord'
require 'pry'
require 'pry-byebug'
require_relative './models/fortune'

class HoroscopeService < Sinatra::Base

  configure do
    env = ENV["SINATRA_ENV"] || "development"
    if env == "production"
       db = URI.parse(ENV['DATABASE_URL'] || 'postgres:///localhost/mydb')
       ActiveRecord::Base.establish_connection(
         :adapter  => db.scheme == 'postgres' ? 'postgresql' : db.scheme,
         :host     => db.host,
         :username => db.user,
         :password => db.password,
         :database => db.path[1..-1],
         :encoding => 'utf8'
       )
    else
      databases = YAML.load_file("config/database.yml") 
      ActiveRecord::Base.establish_connection(databases[env])
    end
  end

  get '/fortune/:date/:sign/' do 
    @f = Fortune.offset(rand(Fortune.count)).take
    @f.fortune.to_json
  end
end