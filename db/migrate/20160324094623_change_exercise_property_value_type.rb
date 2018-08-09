class ChangeExercisePropertyValueType < ActiveRecord::Migration

  def change
    change_column :exercise_properties,
      :value,
      :decimal,
      precision: 12,
      scale: 3

    change_column :exercise_properties,
      :value2,
      :decimal,
      precision: 12,
      scale: 3
  end

end
