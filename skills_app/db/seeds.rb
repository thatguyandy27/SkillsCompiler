require "#{Rails.root}/db/data_reader"
path = '#{Rails.root}/db/data/*.dat'
reader = ScrapedDataReader.new(path)
reader.read_files()