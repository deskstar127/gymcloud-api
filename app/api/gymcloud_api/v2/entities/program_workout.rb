module GymcloudAPI::V2
module Entities

class ProgramWorkout < Grape::Entity

  expose :id
  expose :note
  expose :position
  expose :week_id
  expose :program_id
  expose :program_type
  expose :workout_id
  expose :workout_type
  expose :workout do |model, options|
    entity = "GymcloudAPI::V2::Entities::#{model.workout_type}".constantize
    entity.represent(model.workout, options)
  end
  expose :created_at
  expose :updated_at

end

end
end
