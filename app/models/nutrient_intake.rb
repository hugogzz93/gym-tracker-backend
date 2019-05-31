class NutrientIntake < ApplicationRecord
  belongs_to :user
  validates :value, presence: true
  validates :nutrient_id, presence: true
end
