class AddUniquenessIndexToExerciseResultItem < ActiveRecord::Migration
  def change
    add_index :exercise_result_items,
      [:exercise_property_id, :exercise_result_id],
      unique: true, name: 'exercise_result_item_uniqueness_index'
  end
end
