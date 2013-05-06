class Order < ActiveRecord::Base
  
  attr_accessible :token, :type, :wood_type, :name, :email, :country, :city, :street, :postal_code, :token
  
end
