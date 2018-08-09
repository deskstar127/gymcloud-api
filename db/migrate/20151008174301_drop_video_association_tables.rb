class DropVideoAssociationTables < ActiveRecord::Migration
  def change
    drop_table :exercises_videos
    drop_table :videos_workout_templates
  end
end
