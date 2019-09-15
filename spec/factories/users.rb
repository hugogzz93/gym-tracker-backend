# frozen_string_literal: true

require 'ffaker'
FactoryBot.define do
  factory :user do
    name { FFaker::Name.name }
    email { FFaker::Internet.disposable_email }
    password { '1234' }
  end
end
