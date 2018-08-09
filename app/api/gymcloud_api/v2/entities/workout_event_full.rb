module GymcloudAPI::V2
module Entities

class WorkoutEventFull < Entities::WorkoutEvent

  expose :prev_id do |ev|
    ::WorkoutEvent
      .joins { personal_workout }
      .where { personal_workout.person_id == my { ev.person.id } }
      .where { begins_at < my { ev.begins_at } }
      .order(begins_at: :desc).take&.id
  end

  expose :next_id do |ev|
    ::WorkoutEvent
      .joins { personal_workout }
      .where { personal_workout.person_id == my { ev.person.id } }
      .where { begins_at > my { ev.begins_at } }
      .order(begins_at: :asc).take&.id
  end

  expose :workout_event_exercises, as: :exercises,
          using: Entities::WorkoutEventExercise

end

end
end