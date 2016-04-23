class CreateCourseLectures < ActiveRecord::Migration
  def change
    create_table :course_lectures do |t|
      t.integer :course_id
      t.integer :lecture_id

      t.timestamps null: false
    end
  end
end
