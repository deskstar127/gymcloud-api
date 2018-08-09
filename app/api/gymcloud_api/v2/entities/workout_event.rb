module GymcloudAPI::V2
module Entities

class WorkoutEvent < Grape::Entity

  expose :id
  expose :created_at
  expose :updated_at
  expose :personal_workout_id
  expose :begins_at
  expose :ends_at
  expose :is_completed
  expose :person_id do |event|
    event.personal_workout.person.id
  end
  expose :person_name do |event|
    event.personal_workout.person.user_profile.full_name
  end
  expose :person_avatar do |event|
    event.personal_workout.person.user_profile.avatar.thumb.url
  end
  expose :pro_name,
    unless: {is_pro: true} \
  do |event|
    event.personal_workout.author.user_profile.full_name
  end
  expose :workout_name do |event|
    event.personal_workout.name
  end
  expose :workout_note do |event|
    event.personal_workout.note
  end
  expose :comments, using: Entities::Comment

end

end
end
