#
# Fara Thread-uri
#
require 'open-uri'
require 'nokogiri'

puts "test"

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
links_to_scan.each_with_index do |link,index|
  unless link.include? 'https'
    doc_child = Nokogiri::HTML(open(link))
    File.open("data#{index}.txt", 'w') do |f|
      doc_child.css('h1').each do |node|
        f.write("Thread \n" )
        f.write(node.text + " \n" )
      end
    end
  end
end

# preia linkurile si de la restul de pagini googler
google_pages = []
doc.css('a.fl').each do |node|
  google_pages << uri_address + node['href']
end

end_time = Time.now
puts "Time elapsed #{(end_time - beginning_time)*1000} milliseconds"