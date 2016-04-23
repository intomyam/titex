class CreateLecturePeriods < ActiveRecord::Migration
  def change
    create_table :lecture_periods do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
