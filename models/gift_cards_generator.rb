class GiftcardsGenerator
  def self.generate(existing, amount)
    self.new(existing, amount).generate
  end

  attr_reader :amount, :existing_kodez
  def initialize(existing, amount)
    @existing_kodez = existing
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
      str = str.upcase
      kodez << str
    end
    kodez
  end

  def not_unique?(str)
    existing_kodez.include? str
  end
end
