class MarkWorkoutEventsAsCompleted < ActiveRecord::Migration
  def up
    execute("update workout_events set is_completed = 't'")
  end
end
