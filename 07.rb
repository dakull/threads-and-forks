#
# Cu 2 procese prin fork
#
require 'open-uri'
require 'nokogiri'

#pid_proces_unu = Process.fork do 
#  puts "test"
#end  

#puts pid_proces_unu
#Process.wait
# exit status
#puts "Exit" + $?.exitstatus.to_s

pid_proces_unu = Process.fork do 

  beginning_time = Time.now
  
  # face un google search
  uri_address = "http://google.com"
  search_item = "/search?q=monad"
  doc = Nokogiri::HTML(open(uri_address+search_item))
  
  # afiseaza titlul rezultatelor si href-urile ce vor fi procesate cu threaduri
  links_to_scan = []
  doc.css('h3.r > a.l').each do |link|
    puts link.content
    puts link['href']
    links_to_scan << link['href']
    puts links_to_scan.length
  end
  
  # creaza threadurile si face mici prelucrari per fiecare link
  threads = []
  links_to_scan.each_with_index do |link,index|
    unless link.include? 'https'
      threads << Thread.new do 
        # puts 'In thread'
        # puts link
        doc_child = Nokogiri::HTML(open(link))
        File.open("data#{index}.txt", 'w') do |f|
          doc_child.css('h1').each do |node|
            f.write("Thread #{index}\n" )
            f.write(node.text + " \n" )
          end
        end
      end
    end
  end
  
  # evident
  puts "Nr de threaduri: #{threads.length} \n"
  
  # calculeaza daca threadurile au terminat treaba
  logger = Thread.new do 
    pre_percent = 0
    while true
      current_percent = 0
      threads.each do |thread| 
        unless thread.alive?
          current_percent = current_percent + 100.0/threads.length
        end
      end
      unless current_percent == pre_percent
        puts current_percent.to_s + '%'
        #pre_percent = current_percent
      end
      pre_percent = current_percent
      sleep 0.2
      if current_percent == 100 
        break
      end
    end
  end
  
  # logger join
  logger.join
  
  # join
  threads.each do |thread| 
    thread.join
  end
  
  # preia linkurile si de la restul de pagini googler
  google_pages = []
  doc.css('a.fl').each do |node|
    google_pages << uri_address + node['href']
  end
  
  end_time = Time.now
  puts "Time elapsed #{(end_time - beginning_time)*1000} milliseconds"
  
end  

puts pid_proces_unu
Process.wait
# exit status
puts "Exit" + $?.exitstatus.to_s