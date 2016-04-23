class LectureLecturer < ActiveRecord::Base
  belongs_to :lecture
  belongs_to :lecturer
end
