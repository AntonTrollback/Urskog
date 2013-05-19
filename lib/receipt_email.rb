require_relative '../config/pony_options'

class ReceiptEmail

  attr_reader :order

  def initialize(order)
    @order = order
  end

  def send
    Pony.mail({
      :to => order.email,
      :subject => 'Urskog Receipt',
      :body => "Hi #{order.name},

Thanks for your purchase! This email serves as your receipt. If you have any questions, please contact us anytime at
support@urskog.com.


Email address: #{order.email}
Date: #{order.date}
Order ID: #{order.id}

Retailer: Urskog AB
VAT number: SE556797382001

Product information:
Model: #{order.board} #{order.type_of_purchase} in #{order.wood_type}
Amount: #{order.price} sek (including VAT)

Shipping information:
Country: #{order.country}
City: #{order.city}
Street: #{order.street}
Postal code: #{order.postal_code}


We hope you enjoy your longboard!

The Urskog team
      "
    })
  end
end
