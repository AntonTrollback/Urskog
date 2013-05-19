require_relative '../config/pony_options'

class ReceiptEmail

  attr_reader :order, :board, :calculator

  def initialize(order, board, calculator)
    @order = order
    @board = board
    @calculator = calculator
  end

  def send
    Pony.mail({
      :to => order.email,
      :subject => 'RECEIPT', 
      :html_body => '<b>LOL</b>'
    })
  end
end
