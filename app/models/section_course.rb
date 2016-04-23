class SectionCourse < ActiveRecord::Base
  belongs_to :section
  belongs_to :course
end
