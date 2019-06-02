class NutrientIntakeGoal < ApplicationRecord
  belongs_to :user
  validates :nutrient_id, uniqueness: { scope: :user_id }
end
