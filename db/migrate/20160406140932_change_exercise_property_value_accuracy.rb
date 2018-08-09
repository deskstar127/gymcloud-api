class ChangeExercisePropertyValueAccuracy < ActiveRecord::Migration

  def change
    change_column :exercise_properties,
      :value,
      :decimal,
      precision: 14,
      scale: 5

    change_column :exercise_properties,
      :value2,
      :decimal,
      precision: 14,
      scale: 5
  end

end