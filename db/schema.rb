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
# It's strongly recommended that you check this file into your version control system.
# create the database schema and tables with rake db:migrate
# Each task record will include all of the following. Optional in this context means that the user may choose not to provide this information, but it is still required for your schema:
  # Self-incrementing identifier (ID)
  # title: the title of the task
  # description: details about the task
  # completed_at: the time and date the task was completed


ActiveRecord::Schema.define(version: 20160928211341) do

  create_table "tasks", force: :cascade do |t|
    t.string   "title"
    t.string   "description"
    t.datetime "completed_at"
    t.boolean  "completed"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

end
