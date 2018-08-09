module GymcloudAPI::V2
module Entities

class ExerciseResult < Grape::Entity

  expose :id
  expose :created_at
  expose :updated_at
  expose :workout_event_id
  expose :workout_exercise_id
  expose :is_personal_best
  expose :exercise_result_items, using: Entities::ExerciseResultItem

end

end
end
