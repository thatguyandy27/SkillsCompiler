class ChartsController < ApplicationController

  def show
    @chart = charts[params[:id]] || :column #:column 
  end

  def totals_by_name
    set_data
    @chart_data = SkillTotal.filter_by_name_and_dates(@skills, @startdate, @enddate).
      order("SUM(count) DESC").group(:name).sum(:count)
    render :json => @chart_data
  end

  def totals_by_day
    set_data
    data = SkillTotal.filter_by_name_and_dates(@skills, @startdate, @enddate).group_by(&:name)
    @chart_data = data.map do |key, value| 
      {:name=> key, :data => value.map {|skill_total| [skill_total.date, skill_total.count]}}
    end
    #.map do |skill_total|
    #  {:name => skill_total[:name], :data => {skill_total[:date] => skill_total[:count]}}
    #end

    render :json => @chart_data
  end
  
  private 
    def set_data
      @skills = params[:skills] || SkillTotal.top_skills#SkillTotal.uniq.pluck(:name)
      @startdate = params[:min] || SkillTotal.minimum(:date)
      @enddate = params[:max] || SkillTotal.maximum(:date)

    end
    def charts
      return {"1" => :column, "2"=> :line}
    end
end