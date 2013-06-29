if ENV['RACK_ENV'] == "production"
  Paymill.api_key = "c10774445fa60eda558762c79b968ac3"
else
  Paymill.api_key = "24a9ad50736d90afeb6daa2cdcc2522e"
end
