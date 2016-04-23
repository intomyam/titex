class Department < ActiveRecord::Base
  has_many :lectures
  has_many :sections
end
