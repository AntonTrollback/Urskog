# encoding: utf-8

require 'sinatra/base'
require 'sinatra/asset_pipeline'
require 'rack/ssl'

require 'sinatra/activerecord'

require 'bourbon'
require 'coffee-script'

require_relative 'models/board'
require_relative 'models/retailer'
require_relative 'models/order'

require_relative 'lib/amount_calculator'
require_relative 'lib/paymentprocessor'


class MyApp < Sinatra::Base

  use Rack::SSL

  register Sinatra::ActiveRecordExtension

  configure :development do
    set :database_file, "config/database.yml"
  end
  configure :production do
    db = URI.parse(ENV['HEROKU_POSTGRESQL_JADE_URL'])

    ActiveRecord::Base.establish_connection(
      :adapter  => db.scheme == 'postgres' ? 'postgresql' : db.scheme,
      :host     => db.host,
      :port     => db.port,
      :username => db.user,
      :password => db.password,
      :database => db.path[1..-1],
      :encoding => 'utf8'
    )
  end


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

  # Checkout
  get '/products/:slug/checkout' do
    @board = Board.find(params[:slug])
    redirect "/products" if @board.name.empty?
    @slug = "checkout"
    @title = @board.name
    @buy_option = params[:buy_option]
    @wood_type = params[:wood_type]
    @calculator = AmountCalculator.new(@board.price.send(@buy_option))
    erb :checkout
  end

  post '/checkout/:slug' do
    order = Order.new(params["order"])
    board = Board.find(params[:slug])
    price = board.price.send(params["order"]["type_of_purchase"])
    calculator = AmountCalculator.new(price)

    if order.valid? && Paymentprocessor.purchase(order, board, calculator)
      order.save
      "NICE"
    else
      "LOL"
    end
  end


  # FOR DEBUG
  get '/orders' do
    @orders = Order.all
    erb :orders
  end

  run! if app_file == $0

end
