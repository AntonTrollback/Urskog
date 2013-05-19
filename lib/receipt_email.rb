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
      :html_body => '<b>LOL</b>'
    })
  end
end
