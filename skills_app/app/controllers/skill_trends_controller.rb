class SkillTrendsController < ApplicationController


  def index
    @top_trends = SkillTrend.top_trends
    @bottom_trends = SkillTrend.bottom_trends
  end
end