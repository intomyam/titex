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

ActiveRecord::Schema.define(version: 20160509063841) do

  create_table "course_lectures", force: :cascade do |t|
    t.integer  "course_id",  limit: 4
    t.integer  "lecture_id", limit: 4
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  create_table "courses", force: :cascade do |t|
    t.integer  "code",       limit: 4
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.string   "url",        limit: 255
  end

  create_table "departments", force: :cascade do |t|
    t.integer  "code",       limit: 4
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "lecture_lecturers", force: :cascade do |t|
    t.integer  "lecture_id",  limit: 4
    t.integer  "lecturer_id", limit: 4
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  create_table "lecture_periods", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "lecturers", force: :cascade do |t|
    t.integer  "code",       limit: 4
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "lectures", force: :cascade do |t|
    t.integer  "code",              limit: 4
    t.string   "name",              limit: 255
    t.string   "subject_code",      limit: 255
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.integer  "department_id",     limit: 4
    t.integer  "lecture_period_id", limit: 4
  end

  create_table "section_courses", force: :cascade do |t|
    t.integer  "section_id", limit: 4
    t.integer  "course_id",  limit: 4
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  create_table "section_lectures", force: :cascade do |t|
    t.integer  "section_id", limit: 4
    t.integer  "lecture_id", limit: 4
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  create_table "sections", force: :cascade do |t|
    t.integer  "code",          limit: 4
    t.string   "name",          limit: 255
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.integer  "department_id", limit: 4
    t.string   "url",           limit: 255
  end

end
