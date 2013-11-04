class DMRetailer
  include DataMapper::Resource

  property :id,   Serial
  property :name, String

  has n, :giftcards, :child_key => [:dm_retailer_id]
end
