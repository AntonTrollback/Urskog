# encoding: utf-8

require 'sinatra/base'
require 'yaml'


class Board

  def self.all
    @yaml_file ||= YAML.load_file("boards.yml")
    @boards    ||= boards(@yaml_file)
  end

  def self.find(slug)
    boards = self.all
    boards.select {|b| b.slug == slug }.first || NullBoard.new
  end

  def self.boards(yaml_file)
    boards = []
    yaml_file.each do |item|
      boards << Board.new(item)
    end
    boards
  end

  attr_accessor :name,
                :length,
                :price,
                :slug

  def initialize(attributes={})
    attributes.each do |name, value|
      self.public_send("#{name}=", value)
    end
  end

end

class NullBoard
  def name
    ""
  end

  def slug
    ""
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
    @board = NullBoard.new
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
    @slug = "products"
    @title = @board.name
    erb :product
  end

  run! if app_file == $0

end
