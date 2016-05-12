class AddSchoolTypeToSection < ActiveRecord::Migration
  def change
    add_column :sections, :school_type, :integer, default: 0, null: false
  end
end
