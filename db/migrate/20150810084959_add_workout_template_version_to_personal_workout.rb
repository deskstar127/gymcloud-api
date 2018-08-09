class AddWorkoutTemplateVersionToPersonalWorkout < ActiveRecord::Migration
  def change
    add_column :personal_workouts, :workout_template_version, :integer
  end
end
