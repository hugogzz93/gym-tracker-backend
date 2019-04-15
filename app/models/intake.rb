class Intake < ApplicationRecord
  belongs_to :user
  validates :grams, presence: true
  validates :user, presence: true
  validates :ndbid, presence: true
end
