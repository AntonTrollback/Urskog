class Order
  
  attr_reader :token
  
  def initialize(params)
    @name = params[:name]
    @email = params[:email]
    @country = params[:country]
    @city = params[:city]
    @street = params[:street]
    @postal_code = params[:postal_code]
    @token = params[:paymillToken]
    @wood_type = params[:wood_type]
    @buy_option = params[:buy_option]
  end

  def valid?
    true
  end

  def save
    puts "saved"
    true
  end
end
