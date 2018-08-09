class AddSourceToExerciseProperty < ActiveRecord::Migration
  def change
    add_column :exercise_properties, :source_id, :integer
    add_column :exercise_properties, :source_type, :string
  end
end
