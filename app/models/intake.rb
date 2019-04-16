class Intake < ApplicationRecord
  belongs_to :user
  validates :grams, presence: true
  validates :user, presence: true
  validates :ndbid, presence: true

  def nutrients
    USDA::Api.report([ndbid])[:foods].first['nutrients']
  end
end
