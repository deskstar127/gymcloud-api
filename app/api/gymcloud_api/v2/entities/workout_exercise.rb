module GymcloudAPI::V2
module Entities

class WorkoutExercise < Grape::Entity

  expose :id
  expose :created_at
  expose :updated_at
  expose :display_name, as: :name
  expose :position
  expose :exercise_id
  expose :workout_id
  expose :workout_type
  expose :workout_name do |workout_exercise|
    workout_exercise.workout.name
  end
  expose :note
  expose :video_url do |workout_exercise|
    workout_exercise.source_exercise.video_url
  end
  expose :description do |workout_exercise|
    workout_exercise.source_exercise.description
  end
  expose :exercise_results,
    unless: {nested: false},
    using: Entities::ExerciseResult
  expose :order_name
  expose :exercise_properties,
    unless: {nested: false},
    using: Entities::ExerciseProperty

end

end
end
