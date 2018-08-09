class AddPositionToProgramWorkout < ActiveRecord::Migration
  def change
    add_column :program_workouts, :position, :integer
  end
end
