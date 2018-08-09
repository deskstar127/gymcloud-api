class AddIsProgramPartToPersonalWorkout < ActiveRecord::Migration
  def change
    add_column :personal_workouts, :is_program_part, :boolean, default: false
  end
end
