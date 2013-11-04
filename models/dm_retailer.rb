require 'data_mapper'
require 'dm-timestamps'

class DMRetailer
  include DataMapper::Resource

  property :id,   Serial
  property :name, String
end
