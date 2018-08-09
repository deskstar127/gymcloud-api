class AddSourceToWorkoutExercise < ActiveRecord::Migration
  def change
    add_column :workout_exercises, :source_id, :integer
    add_column :workout_exercises, :source_type, :string
  end
end
