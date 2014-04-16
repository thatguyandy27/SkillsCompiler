class SkillTrend < ActiveRecord::Base
  validates(:name, :presence => true)
  validates(:trend_percentage, :presence => true)

end
