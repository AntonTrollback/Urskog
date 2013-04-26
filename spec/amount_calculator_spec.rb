require_relative '../lib/amount_calculator'

describe AmountCalculator do
  context ".amount" do
    it "should calculate the amount" do
      AmountCalculator.new(49).amount.should == 4900
      AmountCalculator.new(3025).amount.should == 302500
    end
  end
end

