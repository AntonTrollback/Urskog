require 'paymill'
require_relative 'paymill_config'

class Paymentprocessor
  def self.purchase(order, board, calculator)
    Paymill::Transaction.create({
      token:        order.token,
      amount:       calculator.amount,
      currency:     'SEK',
    })
  end
end
