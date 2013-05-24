require 'paymill'
require_relative 'paymill_config'
require_relative 'payment_error_email'

class Paymentprocessor
  def self.purchase(order, board, calculator)
    begin 
      Paymill::Transaction.create({
        token:        order.token,
        amount:       calculator.amount,
        currency:     'SEK',
      })
    rescue => error
      # Email admin
      order.payment_went_wrong = true
      order.save
      PaymentErrorEmail.new(order, error).send
      false
    end
  end
end
