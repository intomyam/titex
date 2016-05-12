class Lecture < ActiveRecord::Base
  belongs_to :department
  belongs_to :lecture_period
  has_many :lecture_lecturers
  has_many :lecturers, through: :lecture_lecturers
  has_many :course_lectures
  has_many :courses, through: :course_lectures
  has_many :section_lectures
  has_many :sections, through: :section_lectures
end
