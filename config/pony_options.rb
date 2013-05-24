require 'pony'

if ENV['RACK_ENV'] == "production"
  ADMIN_EMAILS = 'christopher@schmolzer.se, anton@trollback.se'
else
  ADMIN_EMAILS = 'christopher.schmolzer@gmail.com, anton@trollback.se'
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
