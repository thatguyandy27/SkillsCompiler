class SkillTrend < ActiveRecord::Base
  validates(:name, :presence => true)
  validates(:trend_percentage, :presence => true)

  def self.trending_skills()
    skills = select(:name)

    return skills.map{ |s| s.name} 
  end

  def self.bottom_trends()
    where('trend_percentage < 0')
  end
  def self.top_trends()
    where('trend_percentage > 0')
  end

end
