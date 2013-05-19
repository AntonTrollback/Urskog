require_relative '../config/pony_options'

class OrderEmail

  # TJOFFE MAIL

  attr_reader :order
  
  def initialize(order)
    @order = order
  end

  def send
    Pony.mail({
      :to => 'christopher.schmolzer@gmail.com',
      :subject => 'TJOFFES MAIL', 
      :html_body => "
        <p>Name: #{order.name}</p>
        <p>Email: #{order.email}</p>
        <p>Street: #{order.street}</p>
      "
    })
  end
end
