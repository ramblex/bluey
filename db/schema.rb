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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20110528115949) do

  create_table "body_parts", :force => true do |t|
    t.string   "name"
    t.integer  "x"
    t.integer  "y"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "days", :force => true do |t|
    t.string   "name"
    t.integer  "number"
    t.integer  "plan_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "plan_days_plan_items", :id => false, :force => true do |t|
    t.integer "plan_day_id"
    t.integer "plan_item_id"
  end

  create_table "plan_item_sets", :force => true do |t|
    t.string   "measurements"
    t.integer  "plan_item_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "plan_items", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "day_id"
    t.integer  "position"
    t.boolean  "completed",  :default => false
    t.string   "name"
  end

  create_table "plans", :force => true do |t|
    t.string   "name"
    t.integer  "creator_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "description"
    t.integer  "type_id"
    t.string   "cached_slug"
  end

  create_table "slugs", :force => true do |t|
    t.string   "name"
    t.integer  "sluggable_id"
    t.integer  "sequence",                     :default => 1, :null => false
    t.string   "sluggable_type", :limit => 40
    t.string   "scope"
    t.datetime "created_at"
  end

  add_index "slugs", ["name", "sluggable_type", "sequence", "scope"], :name => "index_slugs_on_n_s_s_and_s", :unique => true
  add_index "slugs", ["sluggable_id"], :name => "index_slugs_on_sluggable_id"

  create_table "user_goals", :force => true do |t|
    t.string   "name"
    t.decimal  "current_value",   :precision => 16, :scale => 2
    t.decimal  "goal_value",      :precision => 16, :scale => 2
    t.string   "unit"
    t.boolean  "is_goal",                                        :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_profile_id"
    t.integer  "body_part_id"
  end

  create_table "user_images", :force => true do |t|
    t.string   "name"
    t.integer  "user_profile_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "picture_file_name"
    t.string   "picture_content_type"
    t.integer  "picture_file_size"
    t.datetime "picture_updated_at"
    t.boolean  "is_profile_picture",   :default => false
  end

  create_table "user_pains", :force => true do |t|
    t.integer  "user_profile_id"
    t.integer  "body_part_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_profiles", :force => true do |t|
    t.string   "name"
    t.text     "summary"
    t.string   "city"
    t.string   "country"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "gym"
    t.text     "sports"
    t.text     "brands"
    t.date     "dob"
    t.text     "symptoms"
  end

  create_table "user_profiles_user_types", :id => false, :force => true do |t|
    t.integer "user_profile_id"
    t.integer "user_type_id"
  end

  create_table "user_profiles_user_wants", :id => false, :force => true do |t|
    t.integer "user_profile_id"
    t.integer "user_want_id"
  end

  create_table "user_types", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_wants", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "email",                               :default => "", :null => false
    t.string   "encrypted_password",   :limit => 128, :default => "", :null => false
    t.string   "password_salt",                       :default => "", :null => false
    t.string   "reset_password_token"
    t.string   "remember_token"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                       :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

  create_table "versions", :force => true do |t|
    t.string   "item_type",  :null => false
    t.integer  "item_id",    :null => false
    t.string   "event",      :null => false
    t.string   "whodunnit"
    t.text     "object"
    t.datetime "created_at"
  end

  add_index "versions", ["item_type", "item_id"], :name => "index_versions_on_item_type_and_item_id"

end
