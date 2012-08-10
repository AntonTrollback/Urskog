require 'sinatra/base'

class MyApp < Sinatra::Base
  @home = false

  get '/' do
    @home = true
    erb :index
  end

  get '/about/?' do
     @title = "About -"
     erb :about
  end

  run! if app_file == $0

end
