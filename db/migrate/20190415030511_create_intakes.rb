class CreateIntakes < ActiveRecord::Migration[5.2]
  def change
    create_table :intakes do |t|
      t.string :ndbid, null: false
      t.string :name, null: false
      t.integer :grams, default: 0, null: false
      t.belongs_to :user, index: true
      t.timestamps
    end
  end
end
