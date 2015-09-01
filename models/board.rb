# encoding: utf-8

require 'yaml'

class Board

  def self.all
    @yaml_file ||= YAML.load_file("data/boards.yml")
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

  attr_reader :name,
              :slug,
              :out_of_stock,
              :price_hash,
              :not_a_board,
              :unlisted,
              :fb_id,
              :woods,
              :promoted_wood,
              :out_of_stock_woods,
              :setup,
              :info,
              :length_hash,
              :width_hash,
              :wheelbase_hash

  def initialize(attributes={})
    @name              = attributes[:name]
    @slug              = attributes[:slug]
    @out_of_stock      = attributes[:out_of_stock]
    @price_hash        = attributes[:price]
    @not_a_board       = attributes[:not_a_board]
    @unlisted          = attributes[:unlisted]
    @fb_id             = attributes[:fb_id]
    @woods             = attributes[:woods]
    @promoted_wood     = attributes[:promoted_wood]
    @out_of_stock_woods = attributes[:out_of_stock_woods]
    @setup             = attributes[:setup]
    @info              = attributes[:info]
    @length_hash       = attributes[:length]
    @width_hash        = attributes[:width]
    @wheelbase_hash    = attributes[:wheelbase]
  end

  def wood_list
    woods.map(&:capitalize).join(", ")
  end

  def price
    @price ||= Price.new(self.price_hash)
  end

  def length
    @length ||= Length.new(self.length_hash)
  end

  def width
    @width ||= Width.new(self.width_hash)
  end

  def wheelbase
    @wheelbase ||= Wheelbase.new(self.wheelbase_hash)
  end

  def deck_only?
    price.complete.nil?
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

class Price
  attr_reader :complete, :deck, :static, :completeusd, :deckusd

  def initialize(price_hash)
    @complete = price_hash[:complete]
    @deck = price_hash[:deck]
    @static = price_hash[:static]
    @completeusd = price_hash[:completeusd]
    @deckusd = price_hash[:deckusd]

  end
end

class Length
  attr_reader :mm, :inch

  def initialize(length_hash)
    @mm = length_hash[:mm]
    @inch = length_hash[:inch]
  end
end

class Width
  attr_reader :mm, :inch

  def initialize(width_hash)
    @mm = width_hash[:mm]
    @inch = width_hash[:inch]
  end
end

class Wheelbase
  attr_reader :mm, :inch

  def initialize(wheelbase_hash)
    @mm = wheelbase_hash[:mm]
    @inch = wheelbase_hash[:inch]
  end
end
