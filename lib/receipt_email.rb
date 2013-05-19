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
      :html_body => "
Hi #{order.name},

Thanks for your purchase! This email serves as your receipt. If you have any questions, please contact us anytime at
support@urskog.com.


Email address: #{order.email}
Date: #{order.date}
Order ID: #{order.id}

Retailer: Urskog AB
VAT number: SE556797382001

Product information:
Model: #{order.board} #{order.type_of_purchase} in #{order.wood_type}
Amount: #{order.price_no_vat} sek (including VAT)

Shipping information:
Country: #{order.price_no_vat}
City: #{order.price_no_vat}
Street: #{order.price_no_vat}
Postal code: #{order.price_no_vat}


We hope you enjoy your longboard!

The Urskog team
      "
    })
  end
end
