class CreateSectionCourses < ActiveRecord::Migration
  def change
    create_table :section_courses do |t|
      t.integer :section_id
      t.integer :course_id

      t.timestamps null: false
    end
  end
end
