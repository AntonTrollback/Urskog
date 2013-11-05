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
require_relative 'models/country'
require_relative 'models/retailer'
require_relative 'models/dm_retailer'
require_relative 'models/coupon'
require_relative 'models/code_generator'
require_relative 'models/giftcard'
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

  configure do
    use Rack::Deflater
  end


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
    @fb_id = "6009404780545"
    erb :index
  end

  get '/about/?' do
    @slug = "about"
    @title = "About"
    erb :about
  end

  get '/retailers/?' do
    @countries = Country.all
    @slug = "retailers"
    @title = "Retailers"
    erb :retailers
  end

  get '/contact/?' do
    @slug = "contact"
    @title = "Contact"
    @fb_id = "6009404782145"
    erb :contact
  end

  get '/information/?' do
    @slug = "information"
    @title = "Information"
    erb :information
  end

  get '/giftcard/?' do
    @slug = "giftcard"
    @fb_id = "6009404792745"
    erb :register_giftcard
  end

  get '/products/?' do
    @boards = Board.all
    @slug = "products"
    @title = "Products"
    @fb_id = "6009404790345"
    erb :products
  end

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


  get '/checkout/:slug' do
    @board = Board.find(params[:slug])
    redirect "/products" if @board.name.empty?
    @slug = "checkout"
    @fb_id = "6009404782345"
    @title = @board.name
    @buy_option = params[:buy_option]
    @wood_type = params[:wood_type]
    @calculator = AmountCalculator.new(@board.price.send(@buy_option))
    erb :'checkout/checkout'
  end

  post '/checkout/:slug' do
    board = Board.find(params[:slug])
    price = board.price.send(params["order"]["type_of_purchase"])
    calculator = AmountCalculator.new(price)
    order = Order.new(params["order"].merge({price: price, board: board.name}))

    begin order.save
      if Paymentprocessor.purchase(order, board, calculator)
        OrderEmail.new(order).send
        ReceiptEmail.new(order).send
        @fb_id = "6009404791345"
        erb :'checkout/success'
      else
        erb :'checkout/payment_error'
      end
    rescue => e
      erb :'checkout/error'
    end
  end


  # Admin login
  get '/login' do
    @slug = "login"
    erb :'admin/login', layout: :admin
  end

  # Dashboard
  get '/admin' do
    @retailers = DMRetailer.all
    erb :'admin/dashboard', layout: :admin
  end

  # Retailers
  post '/admin/retailers/add' do
    retailer = DMRetailer.new(params["retailer"])
    if retailer.save
      @retailers = DMRetailer.all
      erb :'admin/dashboard', layout: :admin
    else
      p retailer.errors
      p "ERROR"
    end
  end

  # Giftcards
  get '/admin/retailers/:id/giftcards' do
    @retailer = DMRetailer.find(params[:id]).first
    @giftcards = @retailer.giftcards.all
    erb :'admin/giftcards', layout: :admin
  end

  post '/admin/retailers/:id/giftcards/add' do
    @retailer = DMRetailer.find(params[:id]).first
    # The generator only creates the codez, add them to the retailer later
    giftcards = CodeGenerator.generate(Giftcard.all.map(&:code),
                                            params["amount"])
    giftcards.each do |g|
      @retailer.giftcards << Giftcard.new({code: g})
    end
    @retailer.save
    redirect "/admin/retailers/#{@retailer.id}/giftcards"
  end

  put '/admin/retailers/:id/giftcards' do
    @retailer = DMRetailer.find(params[:id]).first
    @giftcard = @retailer.giftcards.get(params["giftcard"]["id"])
    @giftcard.update(params["giftcard"])
    @giftcard.save
  end


  # Coupon
  get '/admin/coupons' do
    @coupons = Coupon.all
    erb :'admin/coupons', layout: :admin
  end

  post '/admin/coupons/add' do
    codes = CodeGenerator.generate(Coupon.all.map(&:code),
                                            params["amount"])
    codes.each do |c|
      Coupon.create(params["coupon"].merge({code: c}))
    end
    redirect "/admin/coupons"
  end


  helpers do
    def paymill_public_key
      if ENV['RACK_ENV'] == "production"
        '8a8394c43de70da4013defbee629159a'
      else
        '19628440790b126911007115a22ab887'
      end
    end
  end

  run! if app_file == $0

end
