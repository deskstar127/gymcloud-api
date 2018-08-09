module GymcloudAPI::V2
module Entities

class ClientPerformance < Grape::Entity

  expose :id
  expose :avatar do |client|
    client.user_profile.avatar
  end
  expose :avatar_thumb_url do |client|
    client.user_profile.avatar.thumb.url
  end
  expose :full_name do |client|
    client.user_profile.full_name
  end
  expose :last_week_performance do |client|
    events = client.workout_events.previous_7_days
    events.completed.count.to_f / (events.count.nonzero? || 1)
  end
  expose :this_week_performance do |client|
    events = client.workout_events.last_7_days
    events.completed.count.to_f / (events.count.nonzero? || 1)
  end
  expose :workout_events,
    using: Entities::WorkoutEvent \
  do |client|
    client.workout_events.last_7_days
  end

end

end
end
