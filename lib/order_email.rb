require_relative '../config/pony_options'

class OrderEmail

  attr_reader :order

  def initialize(order)
    @order = order
  end

  def send
    Pony.mail({
      :to => ADMIN_EMAILS,
      :subject => "Ping! Purchase: #{order.board} #{order.type_of_purchase}",
      :body => "Date: #{order.date_time}
ID: #{order.id}
Token: #{order.token}

Product: #{order.board} #{order.type_of_purchase} in #{order.wood_type}
Price: #{order.price} sek (including VAT)

Name: #{order.name}
Email: #{order.email}
Phone: #{order.phone}

#{order.street}
#{order.postal_code} #{order.city}, #{order.country}


Have fun packaging!
"
    })
  end
end
