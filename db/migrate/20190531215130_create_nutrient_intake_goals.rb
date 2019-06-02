class CreateNutrientIntakeGoals < ActiveRecord::Migration[5.2]
  def change
    create_table :nutrient_intake_goals do |t|
      t.belongs_to :user, foreign_key: true, index: true
      t.string :nutrient_id, null: false
      t.float :value, null: false


      t.timestamps
    end
  end
end
