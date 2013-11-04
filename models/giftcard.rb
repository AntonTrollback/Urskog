class Giftcard
  include DataMapper::Resource

  property :id,   Serial
  property :code, String
  property :constructed, Boolean
  property :shipped, Boolean
  property :registered, DateTime
  property :created_at, DateTime
  property :created_on, Date

  belongs_to :d_m_retailer, :child_key => [:dm_retailer_id]

  alias_method :constructed?, :constructed
  alias_method :shipped?, :shipped
end
