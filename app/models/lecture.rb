class Lecture < ActiveRecord::Base
  belongs_to :department
  belongs_to :lecture_period
  has_many :lecture_lecturers
  has_many :lecturers, through: :lecture_lecturers
  has_many :course_lectures
  has_many :course, through: :course_lectures
end
