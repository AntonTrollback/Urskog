# encoding: utf-8

require 'sinatra/base'

class MyApp < Sinatra::Base

  def title
    if defined? @title
      "#{@title} — Urskog Longboard"
    else
      "Urskog Longboard"
    end
  end

  def active(item)
    "is-active" if item == @slug
  end

  get '/' do
    @slug = "home"
    erb :index
  end

  get '/about/?' do
    @slug = "about"
    @title = "About"
    erb :about
  end

  get '/products/?' do
    @slug = "products"
    @title = "Products"
    erb :products
  end

  get '/retailers/?' do
    @slug = "retailers"
    @title = "Retailers"
    erb :retailers
  end

  get '/contact/?' do
    @slug = "contact"
    @title = "Contact"
    erb :contact
  end


  # Products

  get '/products/stubbe?' do
    @slug = "products"
    @title = "Stubbe"
    erb :stubbe
  end

  get '/products/kvist?' do
    @slug = "products"
    @title = "Kvist"
    erb :kvist
  end

  get '/products/kil?' do
    @slug = "products"
    @title = "Kil"
    erb :kil
  end

  get '/products/lov?' do
    @slug = "products"
    @title = "L%C3%B6v"
    erb :lov
  end

  get '/products/pinne?' do
    @slug = "products"
    @title = "Pinne"
    erb :pinne
  end

  get '/products/sticka?' do
    @slug = "products"
    @title = "Sticka"
    erb :sticka
  end

  get '/products/fro?' do
    @slug = "products"
    @title = "Frö"
    erb :@slug
  end

  run! if app_file == $0

end
