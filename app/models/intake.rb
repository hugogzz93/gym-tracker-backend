class Intake < ApplicationRecord
  belongs_to :user
  validates :grams, presence: true, numericality: { greater_than: 0}
  validates :user, presence: true
  validates :ndbid, presence: true

  def nutrients
    USDA::Api.single_report(self)['nutrients']
  end
end
