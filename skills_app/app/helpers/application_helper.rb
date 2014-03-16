module ApplicationHelper
  def list_start(page, number_on_page)
    if page.blank? || page.to_i < 0
      return 1
    end

    return (page.to_i() - 1) * number_on_page  + 1
  end
end
