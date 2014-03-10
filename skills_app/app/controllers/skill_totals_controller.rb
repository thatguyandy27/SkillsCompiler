class SkillTotalsController < ApplicationController

  def show

  end

  def index
    @skill_totals = SkillTotal.daily_total.
      paginate(:page => params[:page]).search(params[:skills])
  end
end