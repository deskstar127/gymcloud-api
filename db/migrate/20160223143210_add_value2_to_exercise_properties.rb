class AddValue2ToExerciseProperties < ActiveRecord::Migration
  def change
    add_column :exercise_properties, :value2, :integer
  end
end
