class DeleteUniqueResultIndex < ActiveRecord::Migration
  def change
    remove_index :exercise_result_items,
      name: 'exercise_result_item_uniqueness_index'
  end
end