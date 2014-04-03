class SkillsController < ApplicationController

  def index
    @skills = SkillTotal.skills_and_count().
      paginate(:page => params[:page]).search(params[:skills])
    
  end


end
