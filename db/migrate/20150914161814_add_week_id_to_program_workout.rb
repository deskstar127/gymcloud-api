class AddWeekIdToProgramWorkout < ActiveRecord::Migration
  def change
    add_column :program_workouts, :week_id, :integer
  end
end
