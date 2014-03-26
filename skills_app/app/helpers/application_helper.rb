module ApplicationHelper
  def list_start(page, number_on_page)
    if page.blank? || page.to_i < 0
      return 1
    end

    return (page.to_i() - 1) * number_on_page  + 1
  end

  def full_title(page_title)
    base_title = "SkillsApp"
    
    if page_title.empty?
      return base_title
    else
      return "#{base_title} - #{page_title}"
    end
    
  end
end
