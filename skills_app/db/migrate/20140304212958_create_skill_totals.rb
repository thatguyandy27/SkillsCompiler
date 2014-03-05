class CreateSkillTotals < ActiveRecord::Migration
  def change
    create_table :skill_totals do |t|
      t.string :name
      t.integer :count
      t.date :date

      t.timestamps
    end
  end
end
