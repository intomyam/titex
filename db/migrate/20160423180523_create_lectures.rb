class CreateLectures < ActiveRecord::Migration
  def change
    create_table :lectures do |t|
      t.integer :code
      t.string :name
      t.string :subject_code

      t.timestamps null: false
    end
  end
end
