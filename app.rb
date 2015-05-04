require 'bundler'
Bundler.require

include BCrypt

# Turn on sessions
use Rack::Session::Cookie, :key => 'rack.session',
    :expire_after => 2592000,
    :secret => SecureRandom.hex(64)

DB = Sequel.connect(ENV['DATABASE_URL'] || 'sqlite://db/main.db')
require './models.rb'

get '/' do
  erb :index
end

post '/' do
  user = User.first(:name => params[:username])
  if user && Password.new(user.password) == params[:password]
    redirect '/main'
  else
    @correct = false
    session["message"] = "Username or Password is incorrect"
  end
end

get '/signup' do
  @message = session["message"]
  @correct = true
  session["message"] = nil

  erb :signup
end

post '/signup' do
  u = User.new
  u.name = params[:new_username]
  u.password = Password.create(params[:new_password])
  u.save

  redirect '/'
end

get 'main' do
  erb :main
end