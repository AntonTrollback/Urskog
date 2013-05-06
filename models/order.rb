class Order < ActiveRecord::Base
  
  attr_accessible :token, :type_of_purchase, :wood_type, :name, :email, :country, :city, :street, :postal_code, :token
  
end
