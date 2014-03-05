class SkillTotal < ActiveRecord::Base

  validates(:date, :presence => true)
  validates(:name, :presence => true)
  validates(:count, :presence => true, :numericality => {:greater_than => 0})
end
