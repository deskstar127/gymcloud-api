module GymcloudAPI::V2
module Entities

class Notification < Grape::Entity

  expose :id
  expose :created_at
  expose :updated_at
  expose :owner_id
  expose :recipient_id
  expose :trackable_id
  expose :trackable_type
  expose :key
  expose :owner_full_name do |notification|
    notification.owner&.user_profile&.full_name
  end
  expose :parent do |notification|
    next({}) if notification.trackable.nil?
    case notification.trackable_type
    when 'ExerciseResult'
      {
        user_id: notification.trackable.person.id,
        personal_workout_id: notification.trackable.workout_exercise.workout_id,
        workout_event_id: notification.trackable.workout_event_id
      }
    when 'Comment'
      {
        user_id: notification.trackable.commentable.person.id,
        personal_workout_id: notification.trackable.commentable
          .personal_workout_id,
        workout_event_id: notification.trackable.commentable.id
      }
    when 'WorkoutEvent'
      {
        user_id: notification.trackable.person.id,
        begins_at: notification.trackable.begins_at
      }
    when 'PersonalWorkout' || 'PersonalProgram'
      {
        user_id: notification.trackable.person.id
      }
    end
  end

end

end
end
