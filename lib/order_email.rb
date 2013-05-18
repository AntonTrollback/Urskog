require 'pony'

Pony.options = { 
  :from => 'order@urskog.com', 
  :via => :smtp, 
  :via_options => { 
    :address              => 'send.one.com',
    :port                 => '2525',
    :enable_starttls_auto => true,
    :user_name            => 'order@urskog.com',
    :password             => 'Openmail',
    :authentication       => :plain, # :plain, :login, :cram_md5, no auth by default
    :domain               => "urskog.com" # the HELO domain provided by the client to the server
  } 
}

class OrderEmail

  def initialize(order, board, calculator)
    @order = order
    @board = board
    @calculator = calculator
  end

  def send
    Pony.mail({
      :to => 'christopher.schmolzer@gmail.com',
      :subject => 'hi', 
      :html_body => '<b>LOL</b>'
    })
  end
end
