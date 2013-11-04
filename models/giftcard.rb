class Giftcard
  include DataMapper::Resource

  property :id,   Serial
  property :code, String

  belongs_to :d_m_retailer, :child_key => [:dm_retailer_id]
end
