require 'bundler'
Bundler.require

DB = Sequel.connect(ENV['DATABASE_URL'] || 'sqlite://db/main.db')
require './models.rb'

get '/' do
  erb :index
end

post '/' do
  if
  end

  get '/signup' do
    erb :signup
  end

  post '/signup' do
    u = User.new
    u.name = params[:new_username]
    u.password = params[:new_password]
    u.save

    redirect '/'
  end