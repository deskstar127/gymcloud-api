class AddPositionToWorkoutExercise < ActiveRecord::Migration
  def change
    add_column :workout_exercises, :position, :integer
  end
end
