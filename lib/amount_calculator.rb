class AmountCalculator
  attr_reader :price

  def initialize(price)
    @price = price
  end

  def amount
    price * 100
  end
end

