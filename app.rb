require 'sinatra/base'

class MyApp < Sinatra::Base

  get '/' do
    erb :index
  end

  get '/about/?' do
     @title = "About -"
     erb :about
  end

  run! if app_file == $0

end
