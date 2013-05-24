# encoding: utf-8

require 'sinatra/base'
require 'sinatra/asset_pipeline'
require 'rack/ssl'

require 'bourbon'
require 'coffee-script'

require 'data_mapper'
require_relative 'config/datamapper_setup'

require_relative 'db/migrations/all_migrations'

require_relative 'lib/order_email'
require_relative 'lib/receipt_email'

require_relative 'models/board'
require_relative 'models/retailer'
require_relative 'models/order'

require_relative 'lib/amount_calculator'
require_relative 'lib/paymentprocessor'


class MyApp < Sinatra::Base

  use Rack::SSL

  # Serve assets using this protocol
  set :assets_protocol, :https

  # CSS minification
  set :assets_css_compressor, :sass

  set :assets_precompile, %w(app.js styles.css styles-no-mq.css *.png *.jpg *.svg *.eot *.ttf *.woff)

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
    board = Board.find(params[:slug])
    price = board.price.send(params["order"]["type_of_purchase"])
    calculator = AmountCalculator.new(price)
    order = Order.new(params["order"].merge({price: price, board: board.name}))

    p order
    p board
    p calculator

    # 1. Validate and save in DB
    begin order.valid? && order.save 
      if Paymentprocessor.purchase(order, board, calculator)
        OrderEmail.new(order).send
        ReceiptEmail.new(order).send
        erb :success
      else
        erb :payment_error
      end
    rescue
      erb :error
    end

  end

  get '/test_email' do
    Pony.mail({
      :to => 'christopher.schmolzer@gmail.com',
      :subject => 'hi',
      :html_body => '<b>LOL</b>'
    })
  end

  # FOR DEBUG
  get '/orders' do
    @orders = Order.all
    erb :orders
  end

  run! if app_file == $0

end
