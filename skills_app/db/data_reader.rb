require 'date'

#path = '*.dat'
#path = '../../Scraper/*.dat'

class ScrapedDataReader

  def initialize(path)
    @path = path
  end

  def read_files()
    file_names = Dir[@path]
    file_names.each do |file_name|
      parse_file(file_name)
    end
  end

  private
    def parse_file(file_name)
      date = get_date(file_name)
      file_data = eval(File.open(file_name, "r").to_a.join(''))
      if file_data
        file_data.each do |pair|
          create_record(pair[0], pair[1], date)
        end
      end
    end

    def create_record(name, count, date)
      SkillTotal.create(:name => name, :count => count.to_i, :date => date)
    end

    def get_date(file_name)
      #puts "file_name #{file_name}"
      matches = /(?<month>\d{1,2})-(?<day>\d{1,2})-(?<year>\d{2,4})/.match(file_name)
      day = matches[:day].to_i
      month = matches[:month].to_i
      year = matches[:year].to_i
      year += 2000 if (year < 2000)
      return Date.new(year, month, day)
    end
end

#reader = ScrapedDataReader.new(path)
#reader.read_files()
