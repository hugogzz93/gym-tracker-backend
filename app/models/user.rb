class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :intakes, dependent: :destroy
  has_many :nutrient_intakes, dependent: :destroy
  has_many :nutrient_intake_goals, dependent: :destroy
end
