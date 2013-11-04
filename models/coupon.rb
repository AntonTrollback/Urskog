class Coupon
  include DataMapper::Resource

  property :id,   Serial
  property :code, String
  property :information, String
  property :discount, Integer
  property :created_at, DateTime
  property :created_on, Date

  belongs_to :giftcard, :required => false
end

