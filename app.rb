require 'bundler'
Bundler.require

DB = Sequel.connect(ENV['DATABASE_URL'] || 'sqlite://db/main.db')
require './models.rb'

get '/' do
  erb :index
end

get '/signup' do
  erb :signup
end

post '/signup' do
  u = User.new
  u.name = params[:name]
  u.password = params[:password]
  u.save
end