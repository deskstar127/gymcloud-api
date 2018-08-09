class ReassignCommentsToWorkoutEvent < ActiveRecord::Migration
  def up
    Comment.find_in_batches(batch_size: 1000) do |group|
      group.each do |comment|
        if comment.commentable_type == 'WorkoutEventExercise'
          comment.commentable = comment.commentable.workout_event
          comment.save!
        end
      end
    end
  end
end
