module GymcloudAPI::V2
module Entities

class WorkoutEventExercise < Grape::Entity

  expose :id
  expose :created_at
  expose :updated_at
  expose :workout_event_id
  expose :workout_exercise_id
  expose :name do |workout_event_exercise|
    workout_event_exercise.workout_exercise.source_exercise.name
  end
  expose :order_name do |workout_event_exercise|
    workout_event_exercise.workout_exercise.order_name
  end
  expose :position do |workout_event_exercise|
    workout_event_exercise.workout_exercise.position
  end
  expose :note do |workout_event_exercise|
    workout_event_exercise.workout_exercise.note
  end
  expose :exercise_results, using: Entities::ExerciseResult
  expose :exercise_properties,
    using: Entities::ExerciseProperty
  expose :previous, if: :expose_previous do |instance, options|
    Entities::WorkoutEventExercise.represent instance.previous,
      options.merge(expose_previous: false)
  end

end

end
end
