class ChangeExerciseResultItemValueType < ActiveRecord::Migration

  def change
    change_column :exercise_result_items,
      :value,
      :decimal,
      precision: 14,
      scale: 5
  end

end
