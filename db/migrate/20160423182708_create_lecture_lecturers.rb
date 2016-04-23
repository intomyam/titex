class CreateLectureLecturers < ActiveRecord::Migration
  def change
    create_table :lecture_lecturers do |t|
      t.integer :lecture_id
      t.integer :lecturer_id

      t.timestamps null: false
    end
  end
end
