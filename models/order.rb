class Order
  def initialize(params)
    @name = params[:name]
    @email = params[:email]
    @country = params[:country]
    @city = params[:city]
    @street = params[:street]
    @postal_code = params[:postal_code]
    @token = params[:token]
  end

  def valid?
    true
  end

  def save
    puts "saved"
    true
  end
end
