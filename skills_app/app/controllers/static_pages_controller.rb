class StaticPagesController < ApplicationController

  def home
    @chart = :column
    @skills = SkillTotal.top_skills
    @startdate = SkillTotal.minimum(:date)
    @enddate = SkillTotal.maximum(:date)

    @chart_data = SkillTotal.filter_by_name_and_dates(@skills, @startdate, @enddate)

  end
end