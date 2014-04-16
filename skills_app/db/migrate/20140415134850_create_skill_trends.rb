class CreateSkillTrends < ActiveRecord::Migration
  def change
    create_table :skill_trends do |t|
      t.string :name
      t.decimal :trend_percentage

      t.timestamps
    end
  end
end
