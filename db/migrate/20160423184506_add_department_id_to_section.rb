class AddDepartmentIdToSection < ActiveRecord::Migration
  def change
    add_column :sections, :department_id, :integer
  end
end
