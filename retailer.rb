# encoding: utf-8

require 'yaml'

class Retailer

  def self.all
    @yaml_file ||= YAML.load_file("retailers.yml")
    @retailers ||= retailers(@yaml_file)
  end

  def self.retailers(yaml_file)
    retailers = []
    yaml_file.each do |item|
      retailers << Retailer.new(item)
    end
    retailers
  end

  attr_reader :name,
              :location,
              :address,
              :website,
              :mail,
              :phone

  def initialize(attributes={})
    @name     = attributes[:name]
    @location = attributes[:location]
    @address  = attributes[:address]
    @website  = attributes[:website]
    @mail     = attributes[:mail]
    @phone    = attributes[:phone]
  end

  def web_only?
    @location == "web"
  end

end