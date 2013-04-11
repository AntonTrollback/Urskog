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
              :length,
              :price_hash,
              :slug,
              :woods

  def initialize(attributes={})
    @name   = attributes[:name]
    @length = attributes[:length]
    @price_hash  = attributes[:price]
    @slug   = attributes[:slug]
    @woods  = attributes[:woods]
  end

  def wood_list
    woods.map(&:capitalize).join(", ")
  end

  def price
    @price ||= Price.new(self.price_hash)
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
  attr_reader :complete, :deck

  def initialize(price_hash)
    @complete = price_hash[:complete]
    @deck = price_hash[:deck]
  end
end
