require_relative '../config/pony_options'

class GiftcardEmail

  attr_reader :name, :email, :code

  def initialize(name, email, code)
    @name = name
    @email = email
    @code = code
  end

  def send
    Pony.mail({
      :to => email,
      :subject => "Your discount code",
      :body => "Dear #{name},

Thank you for registering your gift card!

Here is your 25% discount code: #{code}

Enter your discount code(s) when making a purchase on urskog.com. If you have any questions, please contact us at
support@urskog.com.

Browse products:
https://www.urskog.com/products

We hope you find something you like!

Best,
The Urskog team
"
    })
  end
end



