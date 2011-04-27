#
# threads test 01
#
# puts 'Hello threads'

s1 = Thread.new do 
	puts 'reretest'
	sleep 1
	puts 're-test'
	while true
	  puts 'test'
	end  
end

s2 = Thread.new do 
	while true
	  #sleep 0.1
	  puts 'else'
	end  
end

puts 'smth'

s1.join
s2.join

#puts 'in ||'# Wait for all threads (other than the current thread and
# main thread) to stop running.
# Assumes that no new threads are started while waiting.
#def join_all
#  main = Thread.main        # The main thread
#  current = Thread.current  # The current thread
#  all = Thread.list         # All threads still running
#  # Now call join on each thread
#  all.each {|t| t.join unless t == current or t == main }
#end









