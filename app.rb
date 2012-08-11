require 'sinatra/base'

class MyApp < Sinatra::Base
  @active_page = "home"

  get '/' do
    erb :index
  end

  get '/about/?' do
    @active_page = "about"
    @title = "About -"
    erb :about
  end

  get '/products/?' do
    @active_page = "products"
    @title = "Products -"
    erb :products
  end

  get '/retailers/?' do
    @active_page = "retailers"
    @title = "Retailers -"
    erb :retailers
  end

  get '/contact/?' do
    @active_page = "contact"
    @title = "Contact -"
    erb :contact
  end

  run! if app_file == $0

end
