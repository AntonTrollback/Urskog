# encoding: utf-8

require 'sinatra/base'
require 'sinatra/asset_pipeline'
require 'rack/ssl'

require 'bourbon'
require 'coffee-script'

require_relative 'models/board'
require_relative 'models/retailer'

require_relative 'lib/amount_calculator'


class MyApp < Sinatra::Base

  use Rack::SSL

  # Serve assets using this protocol
  set :assets_protocol, :https

  # CSS minification
  set :assets_css_compressor, :sass

  # JavaScript minification
  set :assets_js_compressor, :uglifier

  register Sinatra::AssetPipeline


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

  before do
    @boards = Board.all
    @board = NullBoard.new
    @retailers = Retailer.all
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

  # List of products
  get '/products/?' do
    @slug = "products"
    @title = "Products"
    erb :products
  end

  # Single product
  get '/products/:slug' do
    @board = Board.find(params[:slug])
    if @board.name == ""
      redirect "/products"
      return
    end
    @slug = "products"
    @title = @board.name
    erb :product
  end

  # BUY
  get '/products/:slug/buy' do
    @board = Board.find(params[:slug])
    redirect "/products" if @board.name.empty?
    @slug = "checkout"
    @title = @board.name
    @buy_option = params[:buy_option]
    @wood_type = params[:wood_type]
    @calculator = AmountCalculator.new(@board.price.send(@buy_option))
    erb :buy
  end

  post '/buy/:slug' do
    p params

    'NICE'
  end

  run! if app_file == $0

end
