class AddOrderNameToWorkoutExercises < ActiveRecord::Migration
  def change
    add_column :workout_exercises, :order_name, :string
  end
end
