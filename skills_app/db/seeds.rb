require "#{Rails.root}/db/data_reader"
puts "start"
path = "#{Rails.root}/db/data/*.dat"
puts path
reader = ScrapedDataReader.new(path)
reader.read_files()
puts "done"