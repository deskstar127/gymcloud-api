module GymcloudAPI::V2
module Entities

class PersonalWorkout < Grape::Entity

  expose :id
  expose :created_at
  expose :updated_at
  expose :name
  expose :description
  expose :note
  expose :video_url
  expose :status
  expose :person_id
  expose :author_id do |workout|
    workout&.author&.id
  end
  expose :workout_exercises,
    if: {nested: true},
    using: Entities::WorkoutExercise,
    as: :exercises
  expose :workout_template_id
  expose :workout_template_version
  expose :is_default_for_group
  expose :is_program_part
  expose :program_name,
    if: (lambda do |workout, _options|
      workout.is_program_part &&
        workout&.program_workout&.program
    end) \
    do |workout|
      workout.program_workout.program.name
    end
end

end
end
