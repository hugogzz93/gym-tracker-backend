class CreateNutrientIntakes < ActiveRecord::Migration[5.2]
  def change
    create_table :nutrient_intakes do |t|
      t.string :nutrient_id, null: false
      t.float :value, null: false
      t.belongs_to :user, null: false, index: true

      t.timestamps
    end
  end
end
