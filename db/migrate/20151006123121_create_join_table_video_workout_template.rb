class CreateJoinTableVideoWorkoutTemplate < ActiveRecord::Migration
  def change
    create_join_table :videos, :workout_templates do |t|
      t.index [:video_id, :workout_template_id],
        name: "video_id_workout_template_id_idx"
      t.index [:workout_template_id, :video_id],
        name: "workout_template_id_video_id_idx"
    end
  end
end
