class AddEndTimeToTasks < ActiveRecord::Migration[6.0]
  def change
    add_column :tasks, :end_time, :date
    add_column :tasks, :start_time, :date
  end
end
