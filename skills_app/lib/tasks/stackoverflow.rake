require 'nokogiri'
require 'open-uri'
require 'date'  

namespace :data do
  URL = 'http://careers.stackoverflow.com/jobs?searchTerm=&location=&pg='
  
  desc "Scrapes stack overflow and imports the data"
  task :import => :environment do
    date = Date.today
    if !SkillTotal.find_by_date(date)
      @page = 1
      @more_pages = true
      @skills_table = Hash.new(0)
      data = get_list()

      data.each do |key, value|
        create_skill_total(key, value, date)
      end
    end
  end

    
    
  private 
    def get_list
      
      while @more_pages
        get_skills_for_page
        @page += 1
      end
      return @skills_table
    end

    def get_page_uri(page)
      return URL + page.to_s
    end
      
    def get_skills_for_page
      page = Nokogiri::HTML(open(get_page_uri(@page)))
      skills =  page.css('a.post-tag.job-link')
      skills.each{|a| @skills_table[a.text] += 1}
      
      @more_pages = page.css('a.prev-next.job-link').any?{|a| a.text == 'next'}
      
    end
 
    def create_skill_total(name, count, date)
      SkillTotal.create(:name => name, :count => count.to_i, :date => date)
    end

end
