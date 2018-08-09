module GymcloudAPI::V2
module Entities

class ExerciseProperty < Grape::Entity

  expose :id
  expose :created_at
  expose :updated_at
  expose :property_unit_id
  expose :property_unit_name do |model|
    model.property_unit&.short_name
  end
  expose :personal_property, with: Entities::PersonalProperty
  expose :workout_exercise_id
  expose :value
  expose :value2
  expose :position

end

end
end
