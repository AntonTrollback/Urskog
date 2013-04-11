# encoding: utf-8

require 'yaml'

class Retailer

  def self.all
    @yaml_file ||= YAML.load_file("data/retailers.yml")
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
              :website_url,
              :mail,
              :phone

  def initialize(attributes={})
    @name     = attributes[:name]
    @location = attributes[:location]
    @address  = attributes[:address]
    @website  = attributes[:website]
    @website_url = attributes[:website_url]
    @mail     = attributes[:mail]
    @phone    = attributes[:phone]
  end

  def web_only?
    @address.nil?
  end

  def address_encoded
    @address_encoded = Rack::Utils.escape(@address)
  end

end