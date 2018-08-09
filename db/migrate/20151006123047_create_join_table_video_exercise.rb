class CreateJoinTableVideoExercise < ActiveRecord::Migration
  def change
    create_join_table :videos, :exercises do |t|
      t.index [:video_id, :exercise_id]
      t.index [:exercise_id, :video_id]
    end
  end
end
