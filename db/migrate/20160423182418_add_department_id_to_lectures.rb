class AddDepartmentIdToLectures < ActiveRecord::Migration
  def change
    add_column :lectures, :department_id, :integer
  end
end
