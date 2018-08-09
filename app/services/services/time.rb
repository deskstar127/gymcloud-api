module Services

class Time < BaseService

  DEFAULT_TIMEZONE = 'UTC'.freeze

  def run
    local_time
  end

  def input_params
    [:user, :time]
  end

  private

  def timezone
    @timezone ||=
      begin
        user_timezone_name = @user.user_profile.timezone
        zone = Timezone[user_timezone_name]
        zone.valid? && zone.name || DEFAULT_TIMEZONE
      end
  end

  def local_time
    @time.in_time_zone(timezone) if @time.respond_to?(:zone)
  end

end

end
