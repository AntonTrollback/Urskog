# encoding: utf-8
require 'yaml'
require_relative 'city'

class Country

  def self.all
    @yaml_file ||= YAML.load_file("data/retailers.yml")
    @countries ||= countries(@yaml_file)
  end

  def self.countries(yaml_file)
    countries = []
    yaml_file.first.each do |item|
      countries << Country.new(item)
    end
    countries
  end

  attr_reader :name,
              :cities

  def initialize(attributes={})
    @name         = attributes.first
    @cities       = City.cities(attributes[1][0])
  end
end
