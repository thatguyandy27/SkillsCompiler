class ChartsController < ApplicationController

  def totals_by_name
    set_data
    @chart_data = SkillTotal.filter_by_name_and_dates(@skills, @startdate, @enddate).
      order("SUM(count) DESC").group(:name).sum(:count)
    render :json => @chart_data
  end
  
  private 
    def set_data
      @chart = :column
      @skills = params[:skills] || SkillTotal.top_skills#SkillTotal.uniq.pluck(:name)
      @startdate = params[:min] || SkillTotal.minimum(:date)
      @enddate = params[:max] || SkillTotal.maximum(:date)

    end
    def charts
      return {1 => :column, 2=> :line}
    end
end