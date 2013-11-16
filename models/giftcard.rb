require 'time'

class Giftcard
  include DataMapper::Resource

  property :id,   Serial
  property :code, String
  property :name, String
  property :email, String
  property :constructed, Boolean
  property :shipped, Boolean
  property :registered, DateTime
  property :created_at, DateTime
  property :created_on, Date

  belongs_to :d_m_retailer, :child_key => [:dm_retailer_id], :required => false
  has n, :coupons

  alias_method :constructed?, :constructed
  alias_method :registered?, :registered
  alias_method :shipped?, :shipped

  def register(name, email)
    self.update({name: name, email: email, registered: Time.now})
  end

  def pretty_registered
    if registered
      registered.to_date
    else
      ""
    end
  end
end
