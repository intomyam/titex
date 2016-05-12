class SectionLecture < ActiveRecord::Base
  belongs_to :section
  belongs_to :lecture
end
