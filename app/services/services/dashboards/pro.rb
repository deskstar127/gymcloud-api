module Services
module Dashboards

class Pro < Client

  private

  def fetch_dashboard
    super.merge(events_scheduled_tomorrow_count: events.tomorrow.count)
  end

  def events
    ::WorkoutEvent.with_clients(@user)
  end

end

end
end
