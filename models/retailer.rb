# encoding: utf-8
class Retailer

  def self.retailers(yaml_file)
    retailers = []
    yaml_file.each do |item|
      retailers << Retailer.new(item.first)
    end
    retailers
  end

  attr_reader :name,
              :country,
              :city,
              :nice_url,
              :url,
              :email,
              :address,
              :meatworld,
              :distribution


  def initialize(attributes={})
    @name         = attributes[:name]
    @country      = attributes[:country]
    @city         = attributes[:city]
    @nice_url     = attributes[:nice_url]
    @url          = attributes[:url]
    @email        = attributes[:email]
    @address      = attributes[:address]
    @meatworld    = attributes[:meatworl]
    @distribution = attributes[:distribution]
  end

  def web_only?
    @address.nil?
  end

  def address_encoded
    @address_encoded = Rack::Utils.escape(@address)
  end

end
