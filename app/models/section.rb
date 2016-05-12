class Section < ActiveRecord::Base
  belongs_to :department
  has_many :section_courses
  has_many :courses, through: :section_courses
  has_many :section_lectures
  has_many :lectures, through: :section_lectures

  enum school_type: { undergraduate: 0, postgraduate: 1 }
end
