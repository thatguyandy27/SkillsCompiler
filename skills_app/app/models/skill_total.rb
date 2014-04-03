class SkillTotal < ActiveRecord::Base
  DEFAULT_SKILL_COUNT = 20
  def self.DEFAULT_SKILL_COUNT
    return DEFAULT_SKILL_COUNT
  end
  #default_scope -> { order('date DESC, name ASC')}
  scope :daily_total, -> { order('date DESC, name ASC')}

  validates(:date, :presence => true)
  validates(:name, :presence => true)
  validates(:count, :presence => true, :numericality => {:greater_than => 0})

  def self.filter_by_name_and_dates(name, start_date, end_date)
    return where("name IN (?) AND date >= ? AND date <= ?", name, start_date, end_date)
  end

  def self.search(skill_name)

    if skill_name
      skill_name.downcase!
      skill_name = find(:all, :conditions => ['name LIKE ?', "#{skill_name}"])
    else
      find(:all)  
    end
  end

  def self.skills_and_count()
    return select(:name, "sum(count) as total").group(:name).order("SUM(count) DESC")
  end

  def self.retrieve_skills()
    return select(:name).group(:name).order(:name).map(&:name)
  end

  

  def self.top_skills()
    skills = select(:name).group(:name).
        order("SUM(count) DESC").take(DEFAULT_SKILL_COUNT)

    return skills.map{ |s| s.name} 
  end
end
