namespace :data do

  #Think about changing this to be N number of days
  #Think about combining the list of jobs.
  desc "Creates trend records for the current day"
  task :trends => [:environment, :import] do
    get_trends()
  end


  private 
    def get_max_date(skill_name)
      return SkillTotal.where('name = ?', skill_name).maximum(:date)
    end

    def get_min_date(skill_name)
      return SkillTotal.where('name = ?', skill_name).minimum(:date)
    end

    def get_trends()
      trending_up = []
      trending_down = []

      skills = SkillTotal.retrieve_skills()
      size = skills.count

      0.upto(9) do |i|
        skill_trend = get_skill_trend(skills[i])
        if skill_trend
          trending_up << skill_trend
          trending_down << skill_trend
        end
      end

      trending_up.sort! {|a, b| b.trend_percentage - a.trend_percentage}
      trending_down.sort! {|a, b| a.trend_percentage - b.trend_percentage}

      10.upto(size -1) do |i|
        skill_trend = get_skill_trend(skills[i])
        is_found = false

        trending_up.each_index do |index|
          if skill_trend.trend_percentage > trending_up[index].trend_percentage
            is_found = true
            trending_up.insert(index, skill_trend)
            break
          end
        end

        if is_found
          trending_up.pop
        else
          trending_down.each_index do |index|
            if skill_trend.trend_percentage < trending_down[index].trend_percentage
              is_found = true
              trending_down.insert(index, skill_trend)
              break
            end
          end

          trending_down.pop if is_found
        end
      end

      create_skill_trends(trending_up, trending_down)
    end

    def create_skill_trends(trending_up, trending_down)
      SkillTrend.delete_all
      trending_up.each do |trend| 
        trend.save
      end
      trending_down.each {|trend| trend.save}

    end

    def get_skill_trend(skill_name)
      start_date = get_min_date(skill_name)
      end_date = get_max_date(skill_name)

      first_skill_total = SkillTotal.where('name = ? AND date = ?', skill_name, start_date).first().count
      last_skill_total = SkillTotal.where('name=? AND date = ?', skill_name, end_date).first().count

      trend_percentage = 0
      trend_percentage = last_skill_total / first_skill_total.to_d - 1 if (first_skill_total > 10 && last_skill_total != 0)

      trend_percentage *= 100

      return SkillTrend.new(:name => skill_name, :trend_percentage =>trend_percentage)
    end

end