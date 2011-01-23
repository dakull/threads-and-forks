#
# Fiber Test
#
buff = "ceva"

fib = Fiber.new do  
  index = 0
  loop do
    File.open("database_table.txt", 'a') do |f|
      f.write("Thread #{index}\n" )
      f.write(buff + " \n" )
    end
    Fiber.yield buff
    index = index + 1
  end
end

20.times do |index| 
  puts fib.resume 
  buff = index.to_s + "ceva"
end