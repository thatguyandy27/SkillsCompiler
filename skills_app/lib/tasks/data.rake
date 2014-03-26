require 'nokogiri'
require 'open-uri'
require 'date'  

namespace :db do

  desc "Fill database with data"
  task :populate => :environment do 
    load_data
  end


  def load_data
    
  end

  private
    def parse_file(file_name)
      date = get_date(file_name)
      if !SkillTotal.find_by_date(date)
        file_data = eval(File.open(file_name, "r").to_a.join(''))
        if file_data
          file_data.each do |pair|
            create_skill_total(pair[0], pair[1], date)
          end
        end
      end
    end

    def create_skill_total(name, count, date)
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


  class StackOverflowScraper
    URL = 'http://careers.stackoverflow.com/jobs?searchTerm=&location=&pg='
    
    def initialize()
      @page = 1
      @more_pages = true
      @skills_table = Hash.new(0)
    end
    
    def get_list
      
      while @more_pages
        get_skills_for_page
        @page += 1
      end
      return @skills_table
    end
    
    
    private 
      def get_page_uri(page)
        return URL + page.to_s
      end
      
      def get_skills_for_page
        page = Nokogiri::HTML(open(get_page_uri(@page)))
        skills =  page.css('a.post-tag.job-link')
        skills.each{|a| @skills_table[a.text] += 1}
        
        @more_pages = page.css('a.prev-next.job-link').any?{|a| a.text == 'next'}
        
      end
  end
end