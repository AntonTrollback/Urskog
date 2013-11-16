require 'securerandom'

kodez = []
check_kodez = []

150.times do |i|
  str = SecureRandom.hex(5)
  str = str.upcase
  if kodez.include? str
    puts "INCLUDE"
  end
  kodez << str
  puts "#{str}"
end
