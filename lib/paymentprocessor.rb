require 'paymill'
require_relative 'paymill_config'

class Paymentprocessor
  def self.purchase(order, board, calculator)
    begin 
      Paymill::Transaction.create({
        token:        order.token,
        amount:       calculator.amount,
        currency:     'SEK',
      })
    rescue
      # Email admin
      false
    end
  end
end
