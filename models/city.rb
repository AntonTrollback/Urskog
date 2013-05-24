require_relative 'retailer'

class City
  attr_reader :name, :retailers

  def self.cities(yaml_file)
    cities = []
    yaml_file.each do |item|
      cities << City.new(item)
    end
    cities
  end

  def initialize(attributes)
    @name = attributes.first
    @retailers = Retailer.retailers(attributes[1])
  end
end
