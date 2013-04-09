# encoding: utf-8

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
                :slug,
                :woods

  def initialize(attributes={})
    @name   = attributes[:name]
    @length = attributes[:length]
    @price  = attributes[:price]
    @slug   = attributes[:slug]
    @woods  = attributes[:woods]
  end

  def wood_list
    woods.map(&:capitalize).join(", ")
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
