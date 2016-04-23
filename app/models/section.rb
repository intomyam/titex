class Section < ActiveRecord::Base
  belongs_to :department
  has_many :section_courses
  has_many :courses, through: :section_courses
end
