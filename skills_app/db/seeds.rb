require "#{Rails.root}/db/data_reader"
path = '../Scraper/*.dat'
reader = ScrapedDataReader.new(path)
reader.read_files()