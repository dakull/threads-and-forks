#
# Cu 2 procese prin fork
# dependente: preprocessor.rb
#
require 'open-uri'
require 'nokogiri'
require './preprocessor.rb'

pid_proces_unu = Process.fork do 
  # putin benchmarking
  beginning_time = Time.now
    prep = Preprocessor.new "http://google.com" "monad"
    prep.start_preprocessor
  end_time = Time.now
  puts "Timpul rularii #{(end_time - beginning_time)*1000} milliseconds"
end

puts pid_proces_unu

Process.wait
# exit status
puts "Exit " + $?.exitstatus.to_s