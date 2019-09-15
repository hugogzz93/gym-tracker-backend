# frozen_string_literal: true

class CreateGoalProfileJob < ApplicationJob
  queue_as :default

  def perform(user)
    nutrients = {
      Water: { nutrient_id: '255', unit: 'g' },
      Energy: { name: 'Energy', nutrient_id: '208', unit: 'kcal' },
      Protein: { name: 'Protein', nutrient_id: '203', unit: 'g' },
      Total: { name: 'Total lipid (fat)', nutrient_id: '204', unit: 'g' },
      Carbohydrate: { name: 'Carbohydrate, by difference', nutrient_id: '205', unit: 'g' },
      Calcium: { name: 'Calcium, Ca', nutrient_id: '301', unit: 'mg' },
      Iron: { name: 'Iron, Fe', nutrient_id: '303', unit: 'mg' },
      Magnesium: { name: 'Magnesium, Mg', nutrient_id: '304', unit: 'mg' },
      Phosphorus: { name: 'Phosphorus, P', nutrient_id: '305', unit: 'mg' },
      Potassium: { name: 'Potassium, K', nutrient_id: '306', unit: 'mg' },
      Sodium: { name: 'Sodium, Na', nutrient_id: '307', unit: 'mg' },
      Zinc: { name: 'Zinc, Zn', nutrient_id: '309', unit: 'mg' },
      VitaminC: { name: 'Vitamin C, total ascorbic acid', nutrient_id: '401', unit: 'mg' },
      Thiamin: { name: 'Thiamin', nutrient_id: '404', unit: 'mg' },
      Riboflavin: { name: 'Riboflavin', nutrient_id: '405', unit: 'mg' },
      Niacin: { name: 'Niacin', nutrient_id: '406', unit: 'mg' },
      VitaminB6: { name: 'Vitamin B-6', nutrient_id: '415', unit: 'mg' },
      Folate: { name: 'Folate, DFE', nutrient_id: '435', unit: 'µg' },
      VitaminB12: { name: 'Vitamin B-12', nutrient_id: '418', unit: 'µg' },
      VitaminA_RAE: { name: 'Vitamin A, RAE', nutrient_id: '320', unit: 'µg' },
      VitaminA_IU: { name: 'Vitamin A, IU', nutrient_id: '318', unit: 'IU' },
      SaturatedFat: { name: 'Fatty acids, total saturated', nutrient_id: '606', unit: 'g' },
      MonosaturatedFat: { name: 'Fatty acids, total monounsaturated', nutrient_id: '645', unit: 'g' },
      PolyunsaturatedFat: { name: 'Fatty acids, total polyunsaturated', nutrient_id: '646', unit: 'g' },
      Cholesterol: { name: 'Cholesterol', nutrient_id: '601', unit: 'mg' },
      VitaminE: { name: 'Vitamin E (alpha-tocopherol', nutrient_id: '323', unit: 'mg' }
    }
    nutrients.each do |_k, v|
      user.nutrient_intake_goals.create(nutrient_id: v[:nutrient_id], value: 0)
    end
  end
end
