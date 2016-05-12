class CreateSectionLectures < ActiveRecord::Migration
  def change
    create_table :section_lectures do |t|
      t.integer :section_id
      t.integer :lecture_id

      t.timestamps null: false
    end
  end
end
