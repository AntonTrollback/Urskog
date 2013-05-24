require_relative '../config/pony_options'

class PaymentErrorEmail

  attr_reader :order, :error

  def initialize(order, error)
    @order = order
    @error = error
  end

  def send
    Pony.mail({
      :to => ADMIN_EMAILS,
      :subject => "ERROR: Purchase: #{order.board} #{order.type_of_purchase}",
      :body => "Order information:
Date: #{order.date_time}
ID: #{order.id}
Token: #{order.token}

Product information:
Model: #{order.board}
Containing: #{order.type_of_purchase}
Wood: #{order.wood_type}
Amount: #{order.price} sek (including VAT)

Customer information:
Name: #{order.name}
Email address: #{order.email}

Shipping information:
Country: #{order.country}
City: #{order.city}
Street: #{order.street}
Postal code: #{order.postal_code}

Error: #{error}

Have fun debugging!

Dr. Website
      "
    })
  end
end



