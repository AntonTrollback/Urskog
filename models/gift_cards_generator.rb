require_relative './giftcard'

class GiftcardsGenerator
  def self.generate(amount)
    self.new(amount).generate
  end

  attr_reader :amount, :existing_kodez
  def initialize(amount)
    @existing_kodez = Giftcard.all.map(&:code)
    @amount = amount.to_i
  end

  def generate
    # Generate new ones
    kodez = []
    amount.times do |i|
      str = SecureRandom.hex(5)
      while not_unique? str
        str = SecureRandom.hex(5)
      end
      str = Giftcard.new({code: str.upcase})
      kodez << str
    end
    kodez
  end

  def not_unique?(str)
    existing_kodez.include? str
  end
end
