class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.integer :code
      t.string :name

      t.timestamps null: false
    end
  end
end
