class Course < ActiveRecord::Base
  has_many :course_lectures
  has_many :lectures, through: :course_lectures
end
