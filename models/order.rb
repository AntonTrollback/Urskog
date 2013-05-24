require 'data_mapper'
require 'dm-timestamps'

class Order
  include DataMapper::Resource

  property :id,   Serial
  property :name, String
  property :email, String
  property :country, String
  property :city, String
  property :street, String
  property :postal_code, String
  property :token, String
  property :wood_type, String
  property :type_of_purchase, String
  property :price, String
  property :board, String
  property :created_at, DateTime
  property :created_on, Date

  def date
    ":)"
  end

end

DataMapper.finalize
