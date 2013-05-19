require_relative '../config/pony_options'

class OrderEmail

  attr_reader :order

  def initialize(order)
    @order = order
  end

  def send
    Pony.mail({
      :to => 'christopher.schmolzer@gmail.com',
      :subject => 'Ping! Purchase: #{order.board} #{order.type_of_purchase}',
      :html_body => "
Order information:
Date: #{order.date}
ID: #{order.id}
Token: #{order.token}

Product information:
Model: #{order.board}
Containing: #{order.type_of_purchase}
Wood: #{order.wood_type}
Amount: #{order.price_no_vat} sek (including VAT)

Customer information:
Name: #{order.name}
Email address: #{order.email}

Shipping information:
Country: #{order.price_no_vat}
City: #{order.price_no_vat}
Street: #{order.price_no_vat}
Postal code: #{order.price_no_vat}


Have fun packaging!

Dr. Website
      "
    })
  end
end



