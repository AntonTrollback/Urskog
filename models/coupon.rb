class Coupon
  include DataMapper::Resource

  property :id,   Serial
  property :code, String
  property :information, String
  property :discount, Integer
  property :created_at, DateTime
  property :created_on, Date
  property :registered, DateTime

  belongs_to :giftcard, :required => false

  def self.valid?(coupon)
    !used?(coupon)
  end

  def self.used?(coupon)
    coupon.nil? || coupon.registered != nil
  end

  def use
    self.update({registered: Time.now})
  end

  def pretty_registered
    if registered
      registered.to_date
    else
      ""
    end
  end
end

