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
      :subject => "Giftcard registered",
      :body => "Tjena, ditt giftcard e reggat!
      Ditt namn : #{name}
      Ditt email : #{email}
      Din kod : #{code}
      "
    })
  end
end



