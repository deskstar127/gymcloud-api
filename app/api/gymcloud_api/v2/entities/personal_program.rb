module GymcloudAPI::V2
module Entities

class PersonalProgram < Grape::Entity

  expose :id
  expose :created_at
  expose :updated_at
  expose :name
  expose :description
  expose :note
  expose :status
  expose :person_id
  expose :author_id do |program|
    program&.author&.id
  end
  expose :weeks_count
  expose :program_workouts,
    if: {nested: true},
    using: Entities::ProgramWorkout,
    as: :workouts
  expose :program_weeks,
    if: {nested: true},
    using: Entities::ProgramWeek,
    as: :weeks
end

end
end
