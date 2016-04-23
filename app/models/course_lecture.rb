class CourseLecture < ActiveRecord::Base
  belongs_to :course
  belongs_to :lecture
end
