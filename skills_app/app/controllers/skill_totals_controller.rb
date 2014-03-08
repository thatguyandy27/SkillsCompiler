class SkillTotalsController < ApplicationController

  def show

  end

  def index
    @skill_totals = SkillTotal.paginate(:page => params[:page])
  end
end