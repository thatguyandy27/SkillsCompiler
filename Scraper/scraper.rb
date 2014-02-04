require 'nokogiri'
require 'open-uri'

#skill_table = Hash.new(0)

#puts skill_table.sort_by {|x,v| -v}


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

scraper = StackOverflowScraper.new

file = File.open('results.dat', 'w')
file.write(scraper.get_list.sort_by {|x,v| -v})


#response = open('http://careers.stackoverflow.com/jobs?searchTerm=&location=')
#response_read = response.read
#puts response.status
#file = File.open('page.html', 'w')
#file.write(response_read) 
#if response.status == 200
#  File. response_read
#else
#  puts "Error #{response_read}"
#end
