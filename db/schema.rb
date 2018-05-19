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

ActiveRecord::Schema.define(version: 2018_05_19_150914) do

  create_table "comm_tbl", force: :cascade do |t|
    t.integer "news_tbl_id"
    t.text "cmname"
    t.text "cmtext"
    t.datetime "cdatetime"
    t.index ["news_tbl_id"], name: "index_comm_tbl_on_news_tbl_id"
  end

  create_table "news_tbl", force: :cascade do |t|
    t.text "username"
    t.text "ntext"
    t.datetime "datetime"
  end

end
