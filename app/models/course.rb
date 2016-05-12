class Course < ActiveRecord::Base
  has_many :course_lectures
  has_many :lectures, through: :course_lectures
  has_many :section_courses
  has_many :sections, through: :section_courses
end
