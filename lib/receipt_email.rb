require_relative '../config/pony_options'

class ReceiptEmail

  attr_reader :order

  def initialize(order)
    @order = order
  end

  def send
    Pony.mail({
      :to => order.email,
      :subject => 'RECEIPT', 
      :html_body => "
        <p>Name: #{order.name}</p>
        <p>Email: #{order.email}</p>
        <p>Street: #{order.street}</p>
      "
    })
  end
end
