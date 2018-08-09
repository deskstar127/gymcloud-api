module GymcloudAPI::V2
module Entities

class Dashboard < Grape::Entity

  expose :events_scheduled_this_week_count
  expose :events_completed_this_week_count
  expose :events_scheduled_last_week_count, if: {is_pro: true}
  expose :events_scheduled_tomorrow_count, if: {is_pro: true}
  expose :events_scheduled_today, using: Entities::WorkoutEvent

end

end
end
