class AddIsDefaultForProToPersonalWorkout < ActiveRecord::Migration
  def change
    add_column :personal_workouts, :is_default_for_group, :boolean
  end
end
