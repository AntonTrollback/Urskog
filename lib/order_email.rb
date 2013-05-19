require_relative '../config/pony_options'

class OrderEmail

  def initialize(order)
    @order = order
  end

  def send
    Pony.mail({
      :to => 'christopher.schmolzer@gmail.com',
      :subject => 'hi', 
      :html_body => '<b>LOL</b>'
    })
  end
end
