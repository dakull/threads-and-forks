threads = []

threads << Thread.new {Do something}
threads << Thread.new {Do something}

threads.each {|thread| thread.join}
