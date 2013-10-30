require 'data_mapper'
require 'dm-timestamps'
require 'bcrypt'

class User
  include DataMapper::Resource
  include BCrypt

  property :id,   Serial
  property :email, String
  property :password, BCryptHash

  def authenticate(attempted_password)
    if self.password == attempted_password
      true
    else
      false
    end
  end
end

DataMapper.finalize
