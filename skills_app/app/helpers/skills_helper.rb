module SkillsHelper

  def careers_link(skill_name, link_name=nil, options={})
    options[:class] ||= "button"
    link_name ||= "Current #{skill_name} postings"
    return link_to(link_name, "http://careers.stackoverflow.com/jobs/tag/" + CGI::escape(skill_name),
      options)
  end

end