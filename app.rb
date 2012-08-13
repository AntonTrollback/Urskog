require 'sinatra/base'

class MyApp < Sinatra::Base
  @active_page = "home"
  @active_subpage = false

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


  # Subpages

  get '/products/stubbe?' do
    @active_page = "products"
    @active_subpage = "stubbe"
    @title = "Stubbe -"
    erb :stubbe
  end

  get '/products/kvist?' do
    @active_page = "products"
    @active_subpage = "kvist"
    @title = "Kvist -"
    erb :kvist
  end

  get '/products/kil?' do
    @active_page = "products"
    @active_subpage = "kil"
    @title = "Kil -"
    erb :kil
  end

  get '/products/lov?' do
    @active_page = "products"
    @active_subpage = "lov"
    @title = "L%C3%B6v -"
    erb :lov
  end

  get '/products/pinne?' do
    @active_page = "products"
    @active_subpage = "pinne"
    @title = "Pinne -"
    erb :pinne
  end

  get '/products/sticka?' do
    @active_page = "products"
    @active_subpage = "sticka"
    @title = "Sticka -"
    erb :sticka
  end

  get '/products/fro?' do
    @active_page = "products"
    @active_subpage = "fro"
    @title = "Fr%C3%B6 -"
    erb :fro
  end



  run! if app_file == $0

end
