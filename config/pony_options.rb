require 'pony'

if ENV['RACK_ENV'] == "production"
  ADMIN_EMAILS = 'order@urskog.com, anton@urskog.com'
else
  ADMIN_EMAILS = 'anton@urskog.com, christopher.schmolzer@gmail.com'
end

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
