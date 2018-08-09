module Services
module Dashboards

class Client < BaseService

  def run
    fetch_dashboard
  end

  def input_params
    [:user]
  end

  private

  def fetch_dashboard
    {
      events_scheduled_this_week_count: events.last_7_days.count,
      events_scheduled_last_week_count: events.previous_7_days.count,
      events_completed_this_week_count: events.last_7_days.completed.count,
      events_scheduled_today: events.today
    }
  end

  def events
    @user.workout_events
  end

end

end
end
