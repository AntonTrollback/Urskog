require 'data_mapper'
require 'dm-timestamps'
require 'active_support/all'

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
  property :payment_went_wrong, Boolean, :default => false
  property :receipt_went_wrong, Boolean, :default => false

  def date
    convert_to_timezone.to_date
  end

  def date_time
    convert_to_timezone
  end

  private

  def convert_to_timezone
    DateTime.parse(self.created_at.to_s).in_time_zone('Stockholm')
  end

end

DataMapper.finalize
