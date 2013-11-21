require_relative '../config/pony_options'

class ReceiptEmail

  attr_reader :order

  def initialize(order)
    @order = order
  end

  def send

    if order.type_of_purchase == "static"
      @model = "Type: #{order.board}"
    else
      @model = "Model: #{order.board} #{order.type_of_purchase} in #{order.wood_type}"
    end

    begin
      Pony.mail({
        :to => order.email,
        :subject => 'Urskog Receipt',
        :body => "Dear #{order.name},

Thank you for your purchase

This email serves as your receipt. If you have any questions, please contact us at
support@urskog.com.


Email address: #{order.email}
Date: #{order.date}
Order ID: #{order.id}

Retailer: Urskog AB
VAT number: SE556797382001

Product information:
#{@model}
Amount: #{order.price} sek (including VAT)

Shipping information:
Country: #{order.country}
City: #{order.city}
Street: #{order.street}
Postal code: #{order.postal_code}


We hope you enjoy your Urskog product!

Best,
The Urskog team
"
      })
    rescue => e
      # Spara i Ordern
      order.receipt_went_wrong = true
      order.receipt_went_wrong_msg = e
      order.save
    end
  end
end
