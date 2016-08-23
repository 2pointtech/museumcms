# encoding: UTF-8
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

ActiveRecord::Schema.define(:version => 20141105164259) do

  create_table "classroom_schedules", :force => true do |t|
    t.string   "title"
    t.text     "feed_url"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "donors_donors", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "row"
    t.string   "photo"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "media", :force => true do |t|
    t.string   "file"
    t.string   "title"
    t.integer  "attachable_id"
    t.string   "attachable_type"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.text     "caption"
  end

  create_table "table_menus", :force => true do |t|
    t.string   "label"
    t.string   "title"
    t.string   "type"
    t.text     "content"
    t.integer  "site_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "table_menus", ["site_id"], :name => "index_table_menus_on_site_id"

  create_table "table_sites", :force => true do |t|
    t.string   "image"
    t.integer  "x"
    t.integer  "y"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.string   "color"
    t.text     "map_description"
  end

  create_table "theater_showings", :force => true do |t|
    t.string   "title"
    t.string   "category"
    t.datetime "when"
    t.integer  "length"
    t.datetime "created_at",                       :null => false
    t.datetime "updated_at",                       :null => false
    t.string   "video"
    t.integer  "existing_video_id"
    t.boolean  "auto_play"
    t.integer  "row",               :default => 0
  end

  create_table "ticketing_events", :force => true do |t|
    t.string   "title"
    t.string   "file"
    t.date     "date"
    t.text     "content"
    t.string   "type"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "ticketing_tickets", :force => true do |t|
    t.string   "title"
    t.float    "price"
    t.text     "content"
    t.string   "type"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.float    "child_price"
    t.boolean  "additional_cost"
  end

  create_table "videos", :force => true do |t|
    t.string   "file"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "name"
  end

end
