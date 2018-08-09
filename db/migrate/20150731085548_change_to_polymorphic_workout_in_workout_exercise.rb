class ChangeToPolymorphicWorkoutInWorkoutExercise < ActiveRecord::Migration
  def change
    remove_index :workout_exercises, :workout_template_id
    rename_column :workout_exercises, :workout_template_id, :workout_id
    add_column :workout_exercises, :workout_type, :string
    add_index :workout_exercises, :workout_id
  end
end
