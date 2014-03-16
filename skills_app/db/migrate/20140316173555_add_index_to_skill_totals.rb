class AddIndexToSkillTotals < ActiveRecord::Migration
  def change
    add_index :skill_totals, :name
    add_index :skill_totals, :date
  end
end
