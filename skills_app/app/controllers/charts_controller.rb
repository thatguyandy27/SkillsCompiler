class ChartsController < ApplicationController

  def show
    @chart = charts[params[:id]]
    @skills = params[:skills] || SkillTotal.uniq.pluck(:name)
    @startdate = params[:min] || SkillTotal.minimum(:date)
    @enddate = params[:max] || SkillTotal.maximum(:date)

    @chart_data = SkillTotal.filter_by_name_and_dates(@skills, @startdate, @enddate)

  end

  private 
    def charts
      return {1 => :column, 2=> :line}
    end
end