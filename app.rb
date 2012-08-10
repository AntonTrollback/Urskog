require 'sinatra/base'

class MyApp < Sinatra::Base
  @home      = false
  @about     = true
  @products  = true
  @retailers = true
  @contact   = true

  get '/' do
    @home = true
    erb :index
  end

  get '/about/?' do
    @about = true
    @title = "About -"
    erb :about
  end

  get '/products/?' do
    @products = true
    @title = "Products -"
    erb :products
  end

  get '/retailers/?' do
    @retailers = true
    @title = "Retailers -"
    erb :retailers
  end

  get '/contact/?' do
    @contact = true
    @title = "Contact -"
    erb :contact
  end

  run! if app_file == $0

end
