module SkillsHelper

  def careers_link(skill_name, options={})
    options[:class] ||= "button"
    return link_to("open", "http://careers.stackoverflow.com/jobs/tag/" + skill_name,
      options)
  end

end