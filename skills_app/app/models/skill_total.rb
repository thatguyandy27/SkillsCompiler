class SkillTotal < ActiveRecord::Base
  DEFAULT_SKILL_COUNT = 15
  default_scope -> { order('date DESC, name ASC')}

  validates(:date, :presence => true)
  validates(:name, :presence => true)
  validates(:count, :presence => true, :numericality => {:greater_than => 0})

  def self.filter_by_name_and_dates(name, start_date, end_date)
    return where("name IN (?) AND date >= ? AND date <= ?", name, start_date, end_date)
  end

  def self.top_skills()
    skills = select(:name).group(:name).
        order("SUM(count) DESC").take(DEFAULT_SKILL_COUNT)

    return skills.map{ |s| s.name} 
  end
end
