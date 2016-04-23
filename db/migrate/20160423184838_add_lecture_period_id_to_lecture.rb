class AddLecturePeriodIdToLecture < ActiveRecord::Migration
  def change
    add_column :lectures, :lecture_period_id, :integer
  end
end
