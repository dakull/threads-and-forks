#
# Process fork test
#

# proces unu
pid_proces_unu = Process.fork do 
  a = 0 
  loop do
    a = a + 1
  end
end
puts "## Fork Process 1 PID: " + pid_proces_unu.to_s

# proces doi
pid_proces_doi = Process.fork do 
  a = 0 
  loop do
    a = a + 1
  end
end
puts "## Fork Process 2 PID: " + pid_proces_doi.to_s