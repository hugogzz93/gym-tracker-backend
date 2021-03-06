# frozen_string_literal: true

# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20_190_531_215_130) do
  # These are extensions that must be enabled in order to support this database
  enable_extension 'plpgsql'

  create_table 'intakes', force: :cascade do |t|
    t.string 'ndbid', null: false
    t.string 'name', null: false
    t.integer 'grams', default: 0, null: false
    t.bigint 'user_id'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['user_id'], name: 'index_intakes_on_user_id'
  end

  create_table 'nutrient_intake_goals', force: :cascade do |t|
    t.bigint 'user_id'
    t.string 'nutrient_id', null: false
    t.float 'value', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['user_id'], name: 'index_nutrient_intake_goals_on_user_id'
  end

  create_table 'nutrient_intakes', force: :cascade do |t|
    t.string 'nutrient_id', null: false
    t.float 'value', null: false
    t.bigint 'user_id', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['user_id'], name: 'index_nutrient_intakes_on_user_id'
  end

  create_table 'users', force: :cascade do |t|
    t.string 'email', default: '', null: false
    t.string 'encrypted_password', default: '', null: false
    t.string 'authentication_token'
    t.string 'reset_password_token'
    t.datetime 'reset_password_sent_at'
    t.datetime 'remember_created_at'
    t.string 'name'
    t.boolean 'admin', default: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['email'], name: 'index_users_on_email', unique: true
    t.index ['reset_password_token'], name: 'index_users_on_reset_password_token', unique: true
  end

  add_foreign_key 'nutrient_intake_goals', 'users'
end
