# encoding: utf-8

require 'sinatra/base'
require 'yaml'


class Board

  def self.all
    # Fetch product info from yml file
    yaml_file = YAML.load_file("boards.yml")
    boards = []
    yaml_file.each do |item|
      boards << Board.new(item)
    end
    boards
  end

  def self.find(slug)
    boards = self.all
    boards.select {|b| b.slug == slug }.first
  end


  attr_reader :name, :length, :price, :slug

  def initialize(params)
    @name = params[:name]
    @length = params[:length]
    @price = params[:price]
    @slug = params[:slug]
  end

end

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

  before do
    @boards = Board.all
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


  # Product
  get '/products/:slug' do
    @board = Board.find(params[:slug])
    @slug = "products"
    @title = "Stubbe"
    erb :product
  end

  run! if app_file == $0

end
